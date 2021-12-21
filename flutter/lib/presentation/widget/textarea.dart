import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';

class TextArea extends StatelessWidget {
  TextArea({
    this.expands = false,
    this.controller, 
    this.hintSize = 14, 
    this.hintText,
    this.initialValue = null, 
    this.contentPadding = null,  
    this.transparency = 0.1, this.maxLines = 6, 
    this.icon, this.secure = false, 
    this.maxLength = null,
    this.minLength = 1
  });
  final String hintText;
  final String initialValue;
  final IconData icon;
  final TextEditingController controller;
  final bool secure, expands;
  final int maxLength, maxLines, minLength;
  final double transparency, hintSize;
  final EdgeInsetsGeometry contentPadding;
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      expands: expands,
      maxLines: maxLines,
      maxLength: maxLength,
      controller: controller,
      obscureText: secure,
      style: TextStyle(fontSize: 14),
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.all(14),
        fillColor: accentColor,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
    );
  }
}