import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';

class Button extends StatelessWidget {
  Button({this.text, this.color, this.onPressed});
  final String text;
  final Color color;
  final void Function() onPressed;

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(text),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return color;
            else if (states.contains(MaterialState.disabled))
              return accentColor;
            return color; // Use the component's default.
          }),
        ),
      ),
    );
  }
}

class ButtonEx extends StatelessWidget {
  ButtonEx({this.text, this.color, this.onPressed});
  final String text;
  final Color color;
  final void Function() onPressed;

  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Text(text),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return color;
            else if (states.contains(MaterialState.disabled))
              return accentColor;
            return color; // Use the component's default.
          }),
        ),
      ),
    );
  }
}

class ButtonExSm extends StatelessWidget {
  ButtonExSm({this.text, this.color, this.onPressed});
  final Widget text;
  final Color color;
  final void Function() onPressed;

  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: text,
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed))
              return color;
            else if (states.contains(MaterialState.disabled))
              return accentColor;
            return color; // Use the component's default.
          }),
        ),
      ),
    );
  }
}

class CircleIconButton extends StatelessWidget {
  CircleIconButton({this.icon, this.color, this.size, this.onPressed});
  final IconData icon;
  final double size;
  final Color color;
  final void Function() onPressed;

  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Icon(icon, size: size),
      ),
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(0),
        shape: MaterialStateProperty.all(CircleBorder()),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed))
            return color;
          else if (states.contains(MaterialState.disabled))
            return accentColor;
          return color;
        }), 
      ),
    );
  }
}