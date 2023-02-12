import 'package:flutter/material.dart';

BoxDecoration buttonBoxDecoration01(){
  return BoxDecoration(
      color: const Color(0xFFA39B9B),
      borderRadius: BorderRadius.circular(15),
      boxShadow: const [
        BoxShadow(
          color: Color(0xFFFDBB2D),
          spreadRadius: 1,
          blurRadius: 8,
          offset: Offset(4, 4),
        ),
        BoxShadow(
          color: Colors.white,
          spreadRadius: 1,
          blurRadius: 8,
          offset: Offset(-4, -4),
        ),
      ]);
}