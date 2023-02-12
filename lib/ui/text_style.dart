import 'package:flutter/material.dart';

Text myText01(
  String text ,
TextAlign textAlign,
  String fontFamily ,
  Color color,
  FontWeight fontWeight,
  double fontSize
){
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(
        fontFamily: fontFamily,
        color: color,
        fontWeight: fontWeight,
        fontSize: fontSize),
  );
}


TextStyle textStyle01(
    String fontFamily,
    Color color,
    FontWeight fontWeight,
    double fontSize
    ){
  return TextStyle(
      fontFamily: fontFamily,
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize
  );
}