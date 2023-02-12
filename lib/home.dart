import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
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
              top: -280 * heightP,
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
                height: 120 * heightP,
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
                        text: 'github.com/iamsayantankar/nsec-2023-sem-06-project-vat',
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue,
                          fontSize: 14,
                          fontFamily: "Inter",
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri.parse('http://github.com/iamsayantankar/nsec-2023-sem-06-project-vat'));
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

            // TODO: Step 06 => Gate Close button
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

          ])),
    );
  }









  Future<void> check() async {
    String thisUser =  await readText("username");
    String thisPass = await readText("password");

    if(thisUser != "00" || thisPass != "00"){

      try {
        Response response = await post(Uri.parse('${api()}/check.php'),
            body: {"username": thisUser, "password": thisPass});

        if (response.statusCode == 200) {

          // ignore: use_build_context_synchronously

          if( response.body.toString() == "0"){
            // ignore: use_build_context_synchronously
            helpToast("None", "Nobody available near gate", context);
          }else if( response.body.toString() == "1"){
            setState((){
              openVisible = true;
              closeVisible = false;

            });
            // ignore: use_build_context_synchronously
            warningToast("Attention", "Some one available near gate", context);
          }else if(response.body.toString() == "2"){
            setState((){
              closeVisible = true;
              openVisible = false;

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

      try {
        Response response = await post(Uri.parse('${api()}/gate_open.php'),
            body: {"username": thisUser, "password": thisPass});

        if (response.statusCode == 200) {
          // ignore: use_build_context_synchronously
          if( response.body.toString() == "1"){
            setState((){
              openVisible = false;
              closeVisible = true;

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
      try {
        Response response = await post(Uri.parse('${api()}/gate_close.php'),
            body: {"username": thisUser, "password": thisPass});

        if (response.statusCode == 200) {
          // ignore: use_build_context_synchronously
          if( response.body.toString() == "1"){
            setState((){
              openVisible = false;
              closeVisible = false;

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
