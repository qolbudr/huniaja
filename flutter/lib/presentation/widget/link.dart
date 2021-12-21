import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';

class Link extends StatelessWidget {
  Link({this.text, this.onTap, this.size});

  final String text;
  final void Function() onTap;
  final double size;

  Widget build(context) {
    return InkWell(
      onTap: onTap,
      child: Text(text, style: TextStyle(fontSize: size, fontWeight: FontWeight.w500, letterSpacing: 0.1, color: primaryColor))
    );
  }
}