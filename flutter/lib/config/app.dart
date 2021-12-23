import 'package:flutter/material.dart';

const apiURL = "http://192.168.43.20/HuniAja";

const Color primaryColor = Color(0xff325baf);
const Color accentColor = Color(0xfff1f5fb);

final textTheme = TextTheme(
  headline1: TextStyle(fontSize: 82, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: Colors.black),
  headline2: TextStyle(fontSize: 51, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: Colors.black),
  headline3: TextStyle(fontSize: 41, fontWeight: FontWeight.w400),
  headline4: TextStyle(fontSize: 29, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: Colors.black),
  headline5: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
  headline6: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Colors.black),
  subtitle1: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: Colors.black),
  subtitle2: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: Colors.black),
);

final textWhiteTheme = TextTheme(
  headline1: TextStyle(fontSize: 82, fontWeight: FontWeight.w300, letterSpacing: -1.5, color: Colors.white),
  headline2: TextStyle(fontSize: 51, fontWeight: FontWeight.w300, letterSpacing: -0.5, color: Colors.white),
  headline3: TextStyle(fontSize: 41, fontWeight: FontWeight.w400, color: Colors.white),
  headline4: TextStyle(fontSize: 29, fontWeight: FontWeight.w400, letterSpacing: 0.25, color: Colors.white),
  headline5: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
  headline6: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Colors.white),
  subtitle1: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.15, color: Colors.white),
  subtitle2: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: Colors.white),
);