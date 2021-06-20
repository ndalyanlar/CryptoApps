import 'package:flutter/material.dart';

//Paths
String logoImgPath = "images/logo1.png";

//Strings
final String userText = "E-Posta veya Telefon";
final String passText = "Parola";
const String AppName = "flypay";
final String loginText = "Giriş";
final String userName = "admin";
final String pass = "admin";
//widgets
final Image mylogo = Image.asset(
  logoImgPath,
);

TextStyle textStyle({fontSize: double, color: Color}) => TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
    );
BorderRadius get loginButtonBorderStyle => BorderRadius.only(
      bottomRight: Radius.circular(100),
      topLeft: Radius.circular(100),
    );
