import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'dart:async';
import 'package:manpro/presentation/screen/home.dart';

class Message extends StatefulWidget {
  Message(this.message);
  final String message;

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  void navigateToHome() async {
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => Home()
      ));
    });
  }

  Widget build(BuildContext contex) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/images/booking.jpg", height: 300),
              SizedBox(height: 15),
              Text("Status", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
              SizedBox(height: 10),
              Text(widget.message, style: textTheme.headline6, textAlign: TextAlign.center)
            ]
          ),
        )
      )
    );
  }
}