import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:date_time_picker/date_time_picker.dart';

class TimePicker extends StatelessWidget {
  TimePicker({this.firstDate, this.lastDate, this.label, this.onChanged, this.icon, this.initialDate, this.controller});
  final DateTime firstDate, lastDate, initialDate;
  final String label;
  final IconData icon;
  final void Function(String) onChanged;
  final TextEditingController controller;

  Widget build(BuildContext context) {
    return DateTimePicker(
      controller: controller,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      dateLabelText: label,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        contentPadding: EdgeInsets.all(14),
        fillColor: accentColor,
        hintText: label,
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