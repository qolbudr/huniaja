import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';

class SquareIcon extends StatelessWidget {
  SquareIcon({this.icon});
  final IconData icon;
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Icon(icon, color: primaryColor),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}

class SquareIconFacility extends StatelessWidget {
  SquareIconFacility({this.icons, this.text});
  final String icons;
  final String text;
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Icon(icon(icons), color: primaryColor),
          Text(text, style: textTheme.subtitle2),
        ],
      ),
      decoration: BoxDecoration(
        color: accentColor,
        borderRadius: BorderRadius.circular(5)
      ),
    );
  }
}

IconData icon(String webIcon) {
  switch(webIcon) {
    case "fa fa-bed":
      return Icons.hotel;
    break;

    case "fa fa-bath":
      return Icons.bathtub;
    break;

    case "fa fa-tint":
      return Icons.waves;
    break;
  }
}