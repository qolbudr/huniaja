import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';

class Select extends StatelessWidget {
  Select({this.onChanged, this.items, this.currentSelectedValue, this.icon, this.text});
  final String currentSelectedValue, text;
  final IconData icon;
  final List<Map<String, dynamic>> items;
  final void Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
  return Container(
    child: FormField<String>(
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(text),
              value: currentSelectedValue,
              isDense: true,
              onChanged: onChanged,
              items: items.map((Map<String, dynamic> value) {
                return DropdownMenuItem<String>(
                  value: value["value"].toString(),
                  child: Text(value["label"].toString()),
                );
              }).toList(),
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            contentPadding: EdgeInsets.all(14),
            fillColor: accentColor,
            hintText: text,
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
      },
    ),
  );
}}