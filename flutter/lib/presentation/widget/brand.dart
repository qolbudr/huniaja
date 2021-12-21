import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';

class Brand extends StatelessWidget {
  Brand({this.size});
  final double size;
  Widget build(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text("Huni", style: TextStyle(fontSize: size, fontWeight: FontWeight.bold)),
        Text("Aja", style: TextStyle(fontSize: size / 2, fontWeight: FontWeight.bold, color: primaryColor, letterSpacing: 0.1)),
      ],
    );
  }
}