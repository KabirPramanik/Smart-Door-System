import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/login.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/toast.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/ui/button_style.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/ui/text_style.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/ui/utils.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/utils/api.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/utils/sharedPref.dart';
import 'package:url_launcher/url_launcher.dart';



class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _MyLoginState createState() => _MyLoginState();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }
}

class _MyLoginState extends State<MyLogin> {

  bool openVisible = false;
  bool closeVisible = false;

  bool exitOpenVisible = false;
  bool exitCloseVisible = false;

  late Position _currentPosition;

  
  @override
  void initState() {
    super.initState();
    check();
  }

  @override
  Widget build(BuildContext context) {
    double widthThis = MediaQuery.of(context).size.width; // Gives the width
    double heightThis = MediaQuery.of(context).size.height; // Gives the height
    double widthPortfolio = 390;
    double heightPortfolio = 844;

    double widthP = widthThis / widthPortfolio;
    double heightP = heightThis / heightPortfolio;

    return Scaffold(
      body: Container(
          decoration: boxDecoration(),

          child: Stack(children: [
            // TODO: Step 01 => Top circle create
            Positioned(
              left: -103 * widthP,
              top: -260 * heightP,
              child: Container(
                width: 550 * widthP,
                height: 550 * heightP,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // TODO: Step 02 => Welcome message create
            Positioned(
              left: -4 * widthP,
              top: 22 * heightP,
              child: SizedBox(
                width: 300 * widthP,
                height: 133 * heightP,
                child: myText01("Cloud door open Project", TextAlign.center, "Inter",
                    const Color(0xFFED1E1E), FontWeight.bold, 40),
              ),
            ),

            // TODO: Step 03 => Welcome message descriptions
            Positioned(
              left: 46 * widthP,
              top: 120 * heightP,
              child: SizedBox(
                width: 242 * widthP,
                height: 140 * heightP,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    myText01(
                        "This app is used for education and project purpose...",
                        TextAlign.center,
                        "Inter",
                        const Color(0xFFFFFFFF),
                        FontWeight.normal,
                        14),
                    myText01(
                        "This application is made from a flutter engine.",
                        TextAlign.center,
                        "Inter",
                        const Color(0xFFFFFFFF),
                        FontWeight.normal,
                        14),
                    myText01(
                        "available at ",
                        TextAlign.center,
                        "Inter",
                        const Color(0xFFFFFFFF),
                        FontWeight.normal,
                        14),
                    RichText(
                      text: TextSpan(
                        text: 'github.com/iamsayantankar/cloud-door-open-project-raspberry_pi_pico_w',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse('http://github.com/iamsayantankar/cloud-door-open-project-raspberry_pi_pico_w'));
                          },
                      ),
                    ),
                  ],
                ),
              ),


            ),


            // TODO: Step 04 => Bottom circle create
            Positioned(
              left: -98 * widthP,
              top: 500 * heightP,
              child: Container(
                width: 700 * widthP,
                height: 700 * heightP,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
            ),

            // TODO: Step 05 => Check button
            Positioned(
              left: 88 * widthP,
              top: 610 * heightP,
              child: GestureDetector(
                onTap: ()  => setState((){
                  check();
                  if (kDebugMode) {
                    print("visible");
                  }
                }),
                child: Container(
                  width: 240 * widthP,
                  height: 75 * heightP,
                  decoration: buttonBoxDecoration01(),
                  child: Center(
                    child: myText01("Check", TextAlign.left, "Inter",
                        Colors.black, FontWeight.w800, 25),
                  ),
                ),
              ),
            ),

            // TODO: Step 06 => Gate Open button
            Positioned(
              left: 88 * widthP,
              top: 710 * heightP,

              child: Visibility(
                visible: openVisible,
                child: GestureDetector(
                  onTap: ()  {
                   gateOpen();
                  },
                  child: Container(
                    width: 240 * widthP,
                    height: 75 * heightP,
                    decoration: buttonBoxDecoration01(),
                    child: Center(
                      child: myText01("Gate Open", TextAlign.left, "Inter",
                          Colors.black, FontWeight.w800, 25),
                    ),
                  ),
                ),
              ),
            ),

            // TODO: Step 07 => Gate Close button
            Positioned(
              left: 88 * widthP,
              top: 710 * heightP,
              child: Visibility(
                visible: closeVisible,
                child: GestureDetector(
                  onTap: () {
                    gateClose();
                  },
                  child: Container(
                    width: 240 * widthP,
                    height: 75 * heightP,
                    decoration: buttonBoxDecoration01(),
                    child: Center(
                      child: myText01("Gate Close", TextAlign.left, "Inter",
                          Colors.black, FontWeight.w800, 25),
                    ),
                  ),
                ),
              ),
            ),



            // TODO: Step 08 => Exit Gate Open button
            Positioned(
              left: 88 * widthP,
              top: 710 * heightP,

              child: Visibility(
                visible: exitOpenVisible,
                child: GestureDetector(
                  onTap: ()  {
                    exitGateOpen();
                  },
                  child: Container(
                    width: 240 * widthP,
                    height: 75 * heightP,
                    decoration: buttonBoxDecoration01(),
                    child: Center(
                      child: myText01("Exit Gate Open", TextAlign.left, "Inter",
                          Colors.black, FontWeight.w800, 25),
                    ),
                  ),
                ),
              ),
            ),

            // TODO: Step 09 => Exit Gate Close button
            Positioned(
              left: 88 * widthP,
              top: 710 * heightP,
              child: Visibility(
                visible: exitCloseVisible,
                child: GestureDetector(
                  onTap: () {
                    exitGateClose();
                  },
                  child: Container(
                    width: 240 * widthP,
                    height: 75 * heightP,
                    decoration: buttonBoxDecoration01(),
                    child: Center(
                      child: myText01("Exit Gate Close", TextAlign.left, "Inter",
                          Colors.black, FontWeight.w800, 25),
                    ),
                  ),
                ),
              ),
            ),

          ])),
    );
  }


  void _getCurrentLocation() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        if (kDebugMode) {
          print("LAT: ${_currentPosition.latitude}, LNG: ${_currentPosition.longitude}");
          print("${_currentPosition.latitude},${_currentPosition.longitude}");
        }
      });
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });
  }

  Position _getCurrentPosition() {
    Geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best, forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
    }).catchError((e) {
      if (kDebugMode) {
        print(e);
      }
    });

    return _currentPosition;
  }

  Future<void> check() async {
    String thisUser =  await readText("username");
    String thisPass = await readText("password");

    if(thisUser != "00" || thisPass != "00"){

      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        if (kDebugMode) {
          print("Location Permission is granted");
        }
        Position thisPos = _getCurrentPosition();
        String myPosition = "${thisPos.latitude},${thisPos.longitude}";
        try {
          Response response = await post(Uri.parse('${api()}/check.php'),
              body: {"username": thisUser, "password": thisPass, "position": myPosition});

          if (response.statusCode == 200) {

            // ignore: use_build_context_synchronously

            if( response.body.toString() == "0"){
              // ignore: use_build_context_synchronously
              helpToast("None", "Nobody available near gate", context);
              openVisible = false;
              closeVisible = false;
              exitOpenVisible = false;
              exitCloseVisible = false;
            }else if( response.body.toString() == "1"){
              setState((){
                openVisible = true;
                closeVisible = false;
                 exitOpenVisible = false;
                 exitCloseVisible = false;

              });
              // ignore: use_build_context_synchronously
              warningToast("Attention", "Some one available near gate", context);
            }else if(response.body.toString() == "2"){
              setState((){
                closeVisible = true;
                openVisible = false;

                exitOpenVisible = false;
                exitCloseVisible = false;

              });
              // ignore: use_build_context_synchronously
              warningToast("Warning", "Gate open, close the door.", context);
            }else if(response.body.toString() == "3"){
              setState((){
                closeVisible = false;
                openVisible = false;

                exitOpenVisible = true;
                exitCloseVisible = false;
              });
              // ignore: use_build_context_synchronously
              warningToast("Warning", "Gate open, close the door.", context);
            }else if(response.body.toString() == "4"){
              setState((){
                closeVisible = false;
                openVisible = false;

                exitOpenVisible = false;
                exitCloseVisible = true;
              });
              // ignore: use_build_context_synchronously
              warningToast("Warning", "Gate open, close the door.", context);
            }else{
              // ignore: use_build_context_synchronously
              failureToast("Unsuccessful", response.body.toString(), context);
            }

            if (kDebugMode) {
              print(response.body.toString());
            }
          } else {
            if (kDebugMode) {
              print(response.body.toString());
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }

      }else{
        if (kDebugMode) {
          print("Location Permission is denied.");
        }
      }

    }else{
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AnonymousLogIn()
          )
      );
    }
  }

  Future<void> gateOpen() async {

    String thisUser =  await readText("username");
    String thisPass = await readText("password");

    if(thisUser != "00" || thisPass != "00"){

      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        if (kDebugMode) {
          print("Location Permission is granted");
        }
        Position thisPos = _getCurrentPosition();
        String myPosition = "${thisPos.latitude},${thisPos.longitude}";

        try {
          Response response = await post(Uri.parse('${api()}/gate_open.php'),
              body: {"username": thisUser, "password": thisPass, "position": myPosition});

          if (response.statusCode == 200) {
            // ignore: use_build_context_synchronously
            if( response.body.toString() == "1"){
              setState((){

                closeVisible = true;
                openVisible = false;

                exitOpenVisible = false;
                exitCloseVisible = false;

              });
              // ignore: use_build_context_synchronously
              successToast("Success", "Gate Open...", context);
            }else{
              // ignore: use_build_context_synchronously
              failureToast("Unsuccessful", response.body.toString(), context);
            }

            if (kDebugMode) {
              print(response.body.toString());
            }
          } else {
            if (kDebugMode) {
              print(response.body.toString());
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }else{
        if (kDebugMode) {
          print("Location Permission is denied.");
        }
      }

    }else{
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AnonymousLogIn()
          )
      );
    }
  }

  Future<void> gateClose() async {

    String thisUser =  await readText("username");
    String thisPass = await readText("password");

    if(thisUser != "00" || thisPass != "00"){

      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        if (kDebugMode) {
          print("Location Permission is granted");
        }
        Position thisPos = _getCurrentPosition();
        String myPosition = "${thisPos.latitude},${thisPos.longitude}";

        try {
          Response response = await post(Uri.parse('${api()}/gate_close.php'),
              body: {"username": thisUser, "password": thisPass, "position": myPosition});

          if (response.statusCode == 200) {
            // ignore: use_build_context_synchronously
            if( response.body.toString() == "1"){
              setState((){
                closeVisible = false;
                openVisible = false;

                exitOpenVisible = true;
                exitCloseVisible = false;

              });
              // ignore: use_build_context_synchronously
              successToast("Successful", "Gate close successfully...", context);
            }else{
              // ignore: use_build_context_synchronously
              failureToast("Unsuccessful", response.body.toString(), context);
            }

            if (kDebugMode) {
              print(response.body.toString());
            }
          } else {
            if (kDebugMode) {
              print(response.body.toString());
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }else{
        if (kDebugMode) {
          print("Location Permission is denied.");
        }
      }

    }else{
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AnonymousLogIn()
          )
      );
    }
  }

  Future<void> exitGateOpen() async {

    String thisUser =  await readText("username");
    String thisPass = await readText("password");

    if(thisUser != "00" || thisPass != "00"){

      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        if (kDebugMode) {
          print("Location Permission is granted");
        }
        Position thisPos = _getCurrentPosition();
        String myPosition = "${thisPos.latitude},${thisPos.longitude}";

        try {
          Response response = await post(Uri.parse('${api()}/exit_gate_open.php'),
              body: {"username": thisUser, "password": thisPass, "position": myPosition});

          if (response.statusCode == 200) {
            // ignore: use_build_context_synchronously
            if( response.body.toString() == "1"){
              setState((){
                closeVisible = false;
                openVisible = false;

                exitOpenVisible = false;
                exitCloseVisible = true;

              });
              // ignore: use_build_context_synchronously
              successToast("Success", "Exit Gate Open...", context);
            }else{
              // ignore: use_build_context_synchronously
              failureToast("Unsuccessful", response.body.toString(), context);
            }

            if (kDebugMode) {
              print(response.body.toString());
            }
          } else {
            if (kDebugMode) {
              print(response.body.toString());
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }else{
        if (kDebugMode) {
          print("Location Permission is denied.");
        }
      }

    }else{
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AnonymousLogIn()
          )
      );
    }
  }

  Future<void> exitGateClose() async {

    String thisUser =  await readText("username");
    String thisPass = await readText("password");

    if(thisUser != "00" || thisPass != "00"){

      if (await Permission.location.request().isGranted) {
        // Either the permission was already granted before or the user just granted it.
        if (kDebugMode) {
          print("Location Permission is granted");
        }
        Position thisPos = _getCurrentPosition();
        String myPosition = "${thisPos.latitude},${thisPos.longitude}";

        try {
          Response response = await post(Uri.parse('${api()}/exit_gate_close.php'),
              body: {"username": thisUser, "password": thisPass, "position": myPosition});

          if (response.statusCode == 200) {
            // ignore: use_build_context_synchronously
            if( response.body.toString() == "1"){
              setState((){
                openVisible = false;
                closeVisible = false;
                exitOpenVisible = false;
                exitCloseVisible = false;

              });
              // ignore: use_build_context_synchronously
              successToast("Successful", "Exit Gate close successfully...", context);
            }else{
              // ignore: use_build_context_synchronously
              failureToast("Unsuccessful", response.body.toString(), context);
            }

            if (kDebugMode) {
              print(response.body.toString());
            }
          } else {
            if (kDebugMode) {
              print(response.body.toString());
            }
          }
        } catch (e) {
          if (kDebugMode) {
            print(e.toString());
          }
        }
      }else{
        if (kDebugMode) {
          print("Location Permission is denied.");
        }
      }

    }else{
      // ignore: use_build_context_synchronously
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const AnonymousLogIn()
          )
      );
    }
  }
  
}
