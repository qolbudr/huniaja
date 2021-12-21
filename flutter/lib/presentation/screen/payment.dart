import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Payment extends StatelessWidget {
  Payment({this.url});
  String url;

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WebView(
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}