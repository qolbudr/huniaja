import 'package:flutter/material.dart';
import 'package:manpro/presentation/screen/owner/owner_home.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/link.dart';
import 'package:manpro/presentation/widget/brand.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/presentation/screen/register.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:manpro/model/auth_login.dart';
import 'package:provider/provider.dart';
import 'package:manpro/presentation/screen/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoading = false;
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  void login(email, password, _) async {
    setState(() {
      isLoading = true;
    });

    try {
      AuthLogin loginData = await ApiService().login(email, password);
      context.read<AuthNotifier>().setAuthData(loginData);
      if(loginData.token.isNotEmpty) {
        if(loginData.user.role == 0) {
          Navigator.pushReplacement(_, MaterialPageRoute(
            builder: (_) => Home()
          ));
        } else {
          Navigator.pushReplacement(_, MaterialPageRoute(
            builder: (_) => OwnerHome()
          ));
        }
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      final snackBar = SnackBar(
        content: Text(e.toString()),
        action: SnackBarAction(
          label: 'Oke',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(_).showSnackBar(snackBar);
    }
  }

  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Brand(size: 40),
              Text("Masuk untuk melanjutkan", style: textTheme.subtitle2),
              SizedBox(height: 40),
              InputIcon(hintText: "Email", icon: Icons.email, controller: emailController),
              SizedBox(height: 10),
              InputIcon(hintText: "Password", icon: Icons.lock, secure: true, controller: passwordController),
              SizedBox(height: 20),
              Button(text: isLoading ? "Sedang Masuk..." : "Masuk", color: primaryColor, onPressed: isLoading ? null : () => login(emailController.value.text, passwordController.value.text, context)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Belum punya akun ?", style: textTheme.subtitle1),
                  SizedBox(width: 5),
                  Link(
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Register()
                    )),
                    text: "Daftar",
                    size: 14,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}