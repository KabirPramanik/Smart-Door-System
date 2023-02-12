from machine import Pin, PWM
import time
import os

woiki_active = True     # If woth with simulation, then this is False or Online simulatikon, this is True

if woiki_active == False:
    import network
    import urequests


def callError(errorMSG):
    print(errorMSG)

ssid = 'ENTER YOUR SSID'
password = 'ENTER YOUR Wi-Fi PASSWORD'
http_API = 'https://raspberry-pi-pico-w.sayantankar.com'

if woiki_active == False:
    wlan.connect(ssid, password)


trig=Pin(1, Pin.OUT)
echo=Pin(2,Pin.IN)

servoPin = PWM(Pin(3))
servoPin.freq(50)

Led_R = PWM(Pin(4))
Led_G = PWM(Pin(5))
Led_B = PWM(Pin(6))


# Define the frequency

Led_R.freq(2000)
Led_G.freq(2000)
Led_B.freq(2000)

def ledRGB(R=255,G=255,B=255):
    Rcode = int(65535-((65535/255)*R))
    Gcode = int(65535-((65535/255)*G))
    Bcode = int(65535-((65535/255)*B))
    Led_R.duty_u16(Rcode)
    Led_G.duty_u16(Gcode)
    Led_B.duty_u16(Bcode)




def setServoCycle (position):
    servoPin.duty_u16(position)
    time.sleep(0.01)


def servo_openStart():
    for pos in range(9000,1000,-50):
        setServoCycle(pos)


def servo_closeStart():
    for pos in range(1000,9000,50):
        setServoCycle(pos)


servo_closeStart()

def servo_open():
    ledRGB(0,255,0)


def servo_close():
    ledRGB(255,0,0)


def servo_checking():
    ledRGB(255,255,0)



waiting_for_login_value = "0"
def waiting_for_login_led():
    while True:
        if waiting_for_login_value == "1":
            ledRGB(255,255,0)
        else:
            break
        time.sleep(0.4)

        if waiting_for_login_value == "1":
            ledRGB(0,0,0)
        else:
            break
        time.sleep(0.4)


has_key_checking_error_value = "0"
def has_key_checking_error_led():
    while True:
        if has_key_checking_error_value == "1":
            ledRGB(255,0,0)
        else:
            break
        time.sleep(0.4)

        if has_key_checking_error_value == "1":
            ledRGB(0,0,0)
        else:
            break
        time.sleep(0.4)




def gate_open_counting(unic_uid):
    gate_open_counting_check_call = 6*2
    while True:
        time.sleep(10)
        if woiki_active == False:
            myAPI = http_API+"/board/auth_close-has.php?unic_uid="+unic_uid
            req = urequests.get(myAPI)
            res = req.content
        else:
            res = "1"

        gate_open_counting_check_call -= 1
        if gate_open_counting_check_call < 0:
            print("Time out\n")
            myAPI = http_API+"/board/close.php"
            req = urequests.get(myAPI)
            res = req.content
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
    waiting_for_login_value = "0"
    servo_open()
    servo_openStart()
    gate_open_counting(unic_uid)



# create function for checking two step verification from mobile
def waiting_for_login_check(unic_uid):
    waiting_for_login_check_call = 12*3
    while True:
        if woiki_active == False:
            myAPI = http_API+"/board/check-has.php?unic_uid="+unic_uid
            req = urequests.get(myAPI)
            res = req.content
        else:
            res = "1"
        if res == "error":
            print("Has key checking error...")
            waiting_for_login_value = "0"
            has_key_checking_error_value = "1"
            has_key_checking_error_led()
            time.sleep(3)
            has_key_checking_error_value = "0"
            waiting_for_login_value = "1"
            waiting_for_login_led()
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
        servo_checking()
        # call api and get a has key
        if woiki_active == False:
            myAPI = http_API+"/board/create-has"
            req = urequests.get(myAPI)
            res = req.content
        else:
            res = "46845684846gvuytu"
        # if response retuern error
        if res == "error":
            print("Has key cretion error...")
            ledRGB(73,97,7)
            time.sleep(2)
            call_unic_id_API_call -= 1
            if call_unic_id_API_call < 0:
                connect_WIFI()
                break
        # if response return has-key
        else:
            waiting_for_login_value = "1"
            # Mobile login start
            waiting_for_login_led()
            # call function for checking two step verification from mobile
            waiting_for_login_check(res)
            break








# ultrasonic sensor active
def call_Ultrasonic_for_object():
    ledRGB(255,0,0)
    while True:
        trig.value(1)
        time.sleep_us(2)
        trig.high()
        time.sleep_us(2)
        trig.low()
        while echo.value()==0:
            siga=time.ticks_us()
        while echo.value()==1:
            sigb=time.ticks_us()
        tm=sigb-siga
        dis=(tm*0.0343)/2

        # if get any object, then call create unic id, and call api
        if (50<dis<500):
            call_unic_id()
            break


        print(dis)
        time.sleep(1)



# connection wifi function
def connect_WIFI():
    #Connect to WLAN
    if woiki_active == False:
        wlan = network.WLAN (network.STA_IF)
        wlan.active(True)
        wlan.connect(ssid, password)
        thisCount = 30
        while wlan.isconnected() == False:
            print('Waiting for connection...')
            ledRGB(0,0,255)
            thisCount -= 1
            if thisCount < 0:
                callError("Please cleck your wifi otherwise, ip is blocked...")
                ledRGB(240,0,192)
                break
            time.sleep(1)


        thisCount = 30
        while True:
            if wlan.status() < 0 or wlan.status() >= 3:
                break
            thisCount -= 1
            print('waiting for get ip...')
            ledRGB(0,204,240)
            if thisCount < 0:
                callError("Could not get any ip...")
                ledRGB(240,116,0)
                break
            time.sleep(1)



        thisCount = 30
        while True:
            if wlan.status() != 3:
                print('waiting for resolve network connection...')
                ledRGB(240,0,100)
            else:
                break

            thisCount -= 1
            if thisCount < 0:
                callError("network connection failed...")
                ledRGB(104,41,110)
                break

            time.sleep(1)

    # call function for ultrasonic sensor active
    call_Ultrasonic_for_object()


connect_WIFI()
