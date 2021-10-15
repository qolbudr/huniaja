import 'package:manpro/config/app.dart';
import 'package:flutter/material.dart';

class InputIcon extends StatelessWidget {
  InputIcon({this.hintText, this.icon, this.secure = false, this.controller, this.onTap = null, this.onChanged = null, this.readOnly = false, this.keyboardType = TextInputType.text});
  final String hintText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool secure, readOnly;
  final TextEditingController controller;
  final void Function() onTap;
  final void Function(String) onChanged;

  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: keyboardType,
      onChanged: onChanged,
      controller: controller,
      obscureText: secure,
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.all(14),
        fillColor: accentColor,
        hintText: hintText,
        prefixIcon: Icon(icon),
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

class Input extends StatelessWidget {
  Input({this.hintText, this.secure = false, this.controller, this.onTap = null, this.onChanged = null, this.readOnly = false, this.keyboardType = TextInputType.text});
  final String hintText;
  final bool secure, readOnly;
  final TextEditingController controller;
  final void Function() onTap;
  final void Function(String) onChanged;
  final TextInputType keyboardType;

  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      onChanged: onChanged,
      keyboardType: keyboardType,
      controller: controller,
      obscureText: secure,
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