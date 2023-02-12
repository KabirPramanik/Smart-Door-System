import 'package:flutter/material.dart';

InputDecoration inputDecoration_01(
    Color colorBorderSide,
    Color colorFocusedBorder,
    Color colorLabelStyle,
    Color colorHelperStyle,
    String textLabel,
    String textHelper,

    ){
  return InputDecoration(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: colorBorderSide),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2, color: colorFocusedBorder),
    ),
    labelText: textLabel,
    labelStyle: TextStyle(
      color: colorLabelStyle,
    ),
    helperText: textHelper,
    helperStyle: TextStyle(
      color: colorHelperStyle,
    ),
  );
}