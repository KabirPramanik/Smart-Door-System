import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/home.dart';
import 'package:raspberry_pi_pico_w_vat_project_sem_06/login.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Color(0xFFFDBB2D),
    statusBarColor: Color.fromARGB(0, 255, 255, 255),
    systemNavigationBarDividerColor: Color(0xFF1A2A6C),
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarContrastEnforced: true,
  ));

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // home: const ChatHomeScreen(),
    home: const AnonymousLogIn(),
    // home: HomeScreenC(),
    routes: {
      // 'register': (context) => MyRegister(),
      'anonymous_login': (context) => const AnonymousLogIn(),
      'first_login': (context) => const MyLogin(),
    //   'home': (context) => const HomeScreen(),
    },
  )

  );
}

