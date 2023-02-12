import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

BoxDecoration boxDecoration(){
  return const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment(0.8, 1),
        colors: [
          Color(0xFF1A2A6C),
          Color(0xFFB21F1F),
          Color(0xFFFDBB2D),
        ],
      ));
}

AppBar appBar(){
  return AppBar(
    systemOverlayStyle: const SystemUiOverlayStyle(
      systemNavigationBarColor:
      Color.fromARGB(234, 4, 255, 142), // Navigation bar
      statusBarColor: Color.fromARGB(0, 255, 255, 255), // Status bar
    ),

    backgroundColor: const Color.fromARGB(255, 246, 26, 10), // status bar color
    brightness: Brightness.light, // status bar brightness
  );
}