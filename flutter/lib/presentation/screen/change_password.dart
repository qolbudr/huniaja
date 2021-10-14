import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/presentation/screen/login.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/snackbar.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/presentation/widget/input.dart';


class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentController, passwordController, confirmationController;

  void initState() {
    super.initState();
    currentController = TextEditingController();
    passwordController = TextEditingController();
    confirmationController = TextEditingController();
  }

  void dispose() {
    currentController.dispose();
    passwordController.dispose();
    confirmationController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Ganti Password"),
            elevation: 0,
          ),
          body: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Text("Password Saat Ini"),
              SizedBox(height: 10),
              Input(controller: currentController, secure: true, hintText: "Password Saat Ini"),
              SizedBox(height: 10),
              Text("Password Baru"),
              SizedBox(height: 10),
              Input(controller: passwordController, secure: true, hintText: "Password Baru"),
              SizedBox(height: 10),
              Text("Konfirmasi Password"),
              SizedBox(height: 10),
              Input(controller: confirmationController, secure: true, hintText: "Konfirmasi Password"),
              SizedBox(height: 20),
              Button(color: primaryColor, text: "Simpan", onPressed: () async {
                try {
                  String message = await ApiService().changePassword(
                    _.authLogin.token,
                    _.authLogin.user.id.toString(),
                    currentController.text,
                    passwordController.text,
                    confirmationController.text,
                  );
                  showSnackbar(context, message);
                  _.logout();
                  return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                    builder: (context) {
                      return Login();
                    }
                  ), (Route<dynamic> route) => false);

                } catch (e) {
                  showSnackbar(context, e.toString());
                }
              }),
            ]
          )
        );
      }
    );
  }
}