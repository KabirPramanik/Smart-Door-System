import urequests
import network
from machine import Pin, PWM
import time

ssid = '12345678'
password = '12345678'
http_API = 'https://raspberry-pi-pico-w.sayantankar.com'


irr = Pin(10, Pin.IN)


servoPinIn = PWM(Pin(3))
servoPinIn.freq(50)

servoPinOut = PWM(Pin(7))
servoPinOut.freq(50)

Led_R = PWM(Pin(4))
Led_G = PWM(Pin(5))
Led_B = PWM(Pin(6))


# Define the frequency

Led_R.freq(2000)
Led_G.freq(2000)
Led_B.freq(2000)


def ledRGB(R=255, G=255, B=255):
    Rcode = int(65535-((65535/255)*R))
    Gcode = int(65535-((65535/255)*G))
    Bcode = int(65535-((65535/255)*B))
    Led_R.duty_u16(Rcode)
    Led_G.duty_u16(Gcode)
    Led_B.duty_u16(Bcode)


def setServoCycle(position):
    servoPinIn.duty_u16(position)
    time.sleep(0.01)


def servo_openStart():
    for pos in range(9000, 6000, -50):
        setServoCycle(pos)


def servo_closeStart():
    for pos in range(6000, 9000, 50):
        setServoCycle(pos)


def setExitServoCycle(position):
    servoPinOut.duty_u16(position)
    time.sleep(0.01)


def servoExitOpenStart():
    for pos in range(9000, 6000, -50):
        setExitServoCycle(pos)


def servoExitCloseStart():
    for pos in range(6000, 9000, 50):
        setExitServoCycle(pos)


servo_closeStart()


def gate_open_counting(unic_uid):
    gate_open_counting_check_call = 6*2
    while True:
        time.sleep(10)
        myAPI = http_API+"/board/auth_close_has.php?unic_uid="+unic_uid
        req = urequests.get(myAPI)
        res = req.content
        res = res.decode()
        print(res)

        gate_open_counting_check_call -= 1
        if gate_open_counting_check_call < 0:
            gateAutoCloseC = 5
            while True:
                myAPI = http_API+"/board/auto_close.php?unic_uid="+unic_uid
                req = urequests.get(myAPI)
                res = req.content
                res = res.decode()
                print(res)
                if (res != "1"):
                    gateAutoCloseC -= 1
                else:
                    break

                if gateAutoCloseC < 0:
                    break

            print("Time out\n")
            servo_closeStart()
            connect_WIFI()
            break

        if res == "1":
            print("Gate close by server\n")
            servo_closeStart()
            connect_WIFI()
            break


def openGate(unic_uid):
    # Code for gate open
    print("Gate open ")
    servo_openStart()
    gate_open_counting(unic_uid)


# create function for checking two step verification from mobile
def waiting_for_login_check(unic_uid):
    waiting_for_login_check_call = 12*3
    while True:
        myAPI = http_API+"/board/check-has.php?unic_uid="+unic_uid
        req = urequests.get(myAPI)
        res = req.content
        res = res.decode()
        print(res)

        if res == "error":
            print("Has key checking error...")
            time.sleep(3)
        else:
            if res == "0":
                print("Login with your id...")
                time.sleep(5)
                waiting_for_login_check_call -= 1
                if waiting_for_login_check_call < 0:
                    print("Time out\n")
                    connect_WIFI()
                    break
            elif res == "1":
                openGate(unic_uid)
                break


# generate a has-key
def call_unic_id():

    call_unic_id_API_call = 5
    while True:
        # call api and get a has key
        myAPI = http_API+"/board/create-has.php"
        req = urequests.get(myAPI)
        res = req.content
        res = res.decode()

        # if response retuern error
        print(res)

        if res == "error":
            print("Has key cretion error...")
            time.sleep(2)
            call_unic_id_API_call -= 1
            if call_unic_id_API_call < 0:
                connect_WIFI()
                break
        # if response return has-key
        else:
            if res.startswith('HAS_'):
                # call function for checking two step verification from mobile
                waiting_for_login_check(res)
                break
            else:
                print("Server error...")
                time.sleep(2)
                call_unic_id_API_call -= 1
                if call_unic_id_API_call < 0:
                    connect_WIFI()
                break


# ultrasonic sensor active
def call_Ultrasonic_for_object():
    print("Continue...")
    ledRGB(255, 0, 0)
    while True:
        print("Continue...")

        if irr.value() == 0:
            call_unic_id()
            break
        time.sleep(1)


# connection wifi function
def connect_WIFI():
    for i in range(5):
        ledRGB(120, 120, 120)
        time.sleep(0.5)
        ledRGB(0, 0, 0)
        time.sleep(0.5)
    # Connect to WLAN
    wlan = network.WLAN(network.STA_IF)
    wlan.active(True)
    wlan.connect(ssid, password)
    thisCount = 30
    while wlan.isconnected() == False:
        print('Waiting for connection...')
        ledRGB(0, 0, 255)
        thisCount -= 1
        if thisCount < 0:
            print("Please cleck your wifi otherwise, ip is blocked...")
            ledRGB(240, 0, 192)
            break
        time.sleep(1)

    thisCount = 30
    while True:
        if wlan.status() < 0 or wlan.status() >= 3:
            break
        thisCount -= 1
        print('waiting for get ip...')
        ledRGB(0, 204, 240)
        if thisCount < 0:
            print("Could not get any ip...")
            ledRGB(240, 116, 0)
            break
        time.sleep(1)

    thisCount = 30
    while True:
        if wlan.status() != 3:
            print('waiting for resolve network connection...')
            ledRGB(240, 0, 100)
        else:
            break

        thisCount -= 1
        if thisCount < 0:
            print("network connection failed...")
            ledRGB(104, 41, 110)
            break

        time.sleep(1)

    # call function for ultrasonic sensor active
    print("Done")
    call_Ultrasonic_for_object()


connect_WIFI()


# Code for exit gate
while True:
    time.sleep(5)
    myAPI01 = http_API+"/board/exit_open.php"
    req1 = urequests.get(myAPI01)
    res1 = req1.content
    res1 = res1.decode()
    print(res1)
    if reres1s == "error":
        print("Has key cretion error...")
        time.sleep(2)
        call_unic_id_API_call -= 1
        if call_unic_id_API_call < 0:
            connect_WIFI()
            break
    elif res1 == "0":
        continue
    else:
        if res.startswith('HAS_'):
            # call function for open exit door...
            servoExitOpenStart()
            servoExitDoorCountDown = 12*3
            while True:
                myAPI02 = http_API+"/board/exit_close.php?unic_uid="+res1
                req2 = urequests.get(myAPI02)
                res2 = req2.content
                res2 = res2.decode()

                if (res2 == "1"):
                    # call function for close exit door...
                    servoExitCloseStart()
                    break
                servoExitDoorCountDown -= 1
                time.sleep(5)
                if res2 == "0":
                    if servoExitDoorCountDown < 0:
                        myAPI03 = http_API+"/board/exit_close_auto.php?unic_uid="+res1
                        req3 = urequests.get(myAPI03)
                        res3 = req3.content
                        res3 = res3.decode()
                        break

        else:
            print("Server error...")
            time.sleep(2)
            call_unic_id_API_call -= 1
            if call_unic_id_API_call < 0:
                connect_WIFI()
            break
