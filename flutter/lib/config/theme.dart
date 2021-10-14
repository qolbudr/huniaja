import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:manpro/config/app.dart';

ThemeData themeData = ThemeData(
  // backgroundColor: Colors.white,
  fontFamily: "Rubik",
  primaryTextTheme: textTheme,
  // scaffoldBackgroundColor: Colors.white,
  primaryColor: primaryColor,
  appBarTheme: AppBarTheme(
    elevation: 2,
    backgroundColor: Colors.white,
    iconTheme: IconThemeData(
      color: Colors.black
    ),
  ),
);