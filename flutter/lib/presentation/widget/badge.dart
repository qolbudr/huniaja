import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';

class Badge extends StatelessWidget {
	Badge({this.text, this.color});

	final String text;
	final Color color;

	Widget build(BuildContext context) {
		return Container(
			margin: EdgeInsets.only(right: 3),
			decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    ), padding: EdgeInsets.symmetric(vertical: 5, horizontal: 8), child: Text(text, style: textWhiteTheme.subtitle2));
	}
}