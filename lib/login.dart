import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/home.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/toast.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/ui/button_style.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/ui/edit_text_style.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/ui/text_style.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/ui/utils.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/utils/api.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/utils/sharedPref.dart';
import 'package:url_launcher/url_launcher.dart';


class AnonymousLogIn extends StatefulWidget {
  const AnonymousLogIn({Key? key}) : super(key: key);

  @override
  State<AnonymousLogIn> createState() => _AnonymousLogInState();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
    );
  }
}

class _AnonymousLogInState extends State<AnonymousLogIn> {
  TextEditingController usernameTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  void initState() {
    usernameTextEditingController.text = "";
    passwordTextEditingController.text = "";
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


          // TODO: Step 04 => Edit Text - username

          // TODO: Step 05 => Edit Text - username
          Positioned(
            left: 17 * widthP,
            top: 375 * heightP,
            child: SizedBox(
              width: 356 * widthP,
              height: 70 * heightP,
              child: TextFormField(
                  controller: usernameTextEditingController,
                  keyboardType: TextInputType.text,
                  textAlign: TextAlign.left,
                  maxLength: 20,
                  style: textStyle01(
                      "Inter", const Color(0xFF000000), FontWeight.w800, 20),
                  onChanged: (text) {
                    if (kDebugMode) {
                      print('First text field: $text');
                    }
                  },
                  decoration: inputDecoration_01(
                      const Color(0xFFE31919),
                      Colors.amberAccent,
                      const Color(0xFFA39B9B),
                      const Color(0xFFA39B9B),
                      'username',
                      'Use 0-9 and a-z and A-Z only...')),
            ),
          ),

          // TODO: Step 06 => Edit Text - Password
          Positioned(
            left: 17 * widthP,
            top: 475 * heightP,
            child: SizedBox(
              width: 356 * widthP,
              height: 70 * heightP,
              child: TextFormField(
                  controller: passwordTextEditingController,
                  keyboardType: TextInputType.visiblePassword,
                  textAlign: TextAlign.left,
                  maxLength: 20,
                  style: textStyle01(
                      "Inter", const Color(0xFF000000), FontWeight.w800, 20),
                  onChanged: (text) {
                    if (kDebugMode) {
                      print('First text field: $text');
                    }
                    // print(EmailValidator.validate(text, true));
                  },
                  decoration: inputDecoration_01(
                      const Color(0xFFE31919),
                      Colors.amberAccent,
                      const Color(0xFFA39B9B),
                      const Color(0xFFA39B9B),
                      'password',
                      'enter password')),
            ),
          ),

          // TODO: Step 07 => Bottom circle create
          Positioned(
            left: 172 * widthP,
            top: 672 * heightP,
            child: Container(
              width: 370 * widthP,
              height: 370 * heightP,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),

          // TODO: Step 07 => Enter button
          Positioned(
            left: 234 * widthP,
            top: 750 * heightP,
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const AnonymousLogIn())
                // );
                logIn(
                    usernameTextEditingController.text.toString(),
                    passwordTextEditingController.text.toString()
                );
              },
              child: Container(
                width: 128 * widthP,
                height: 51 * heightP,
                decoration: buttonBoxDecoration01(),
                child: Center(
                  child: myText01("ENTER", TextAlign.left, "Inter",
                      Colors.black, FontWeight.bold, 20),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  logIn( username, password) async {
      if (kDebugMode) {
        print("Successful post meth...");
      }

      try {
        Response response = await post(Uri.parse('${api()}/login.php'),
            body: {"username": username, "password": password});

        if (response.statusCode == 200) {

          // ignore: use_build_context_synchronously

          if( response.body.toString() == "1"){
            saveText( "username",  username);
            saveText( "password",  password);
            // ignore: use_build_context_synchronously
            successToast("Successful", "Login Successfully...", context);

            // ignore: use_build_context_synchronously
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyLogin()
                )
            );
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
  }

  Future<void> check() async {
    String thisUser =  await readText("username");
    String thisPass = await readText("password");

    if(thisUser != "00" || thisPass != "00"){
      logIn(thisUser, thisPass);
    }
  }
}
