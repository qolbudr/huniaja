import 'package:flutter/material.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/link.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/service/api_service.dart';
import 'package:manpro/presentation/screen/camera.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final password_confirmation = TextEditingController();
  bool isUser = false;
  bool isLoading = false;

  void validateRegisterForm(_) async {
    String valueName = name.value.text;
    String valueEmail = email.value.text;
    String valuePassword = password.value.text;
    String valuePasswordConfirmation = password_confirmation.value.text;
    String role = isUser ? '1' : '0';

    setState(() {
        isLoading = true;
      });

    try {
      await ApiService().validateRegisterForm(valueName, valueEmail, valuePassword, valuePasswordConfirmation, role);
      setState(() {
        isLoading = false;
      });
      Navigator.push(_, MaterialPageRoute(
        builder: (_) => Camera(valueName, valueEmail, valuePassword, role)
      ));
    } catch(e) {
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

  @override void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    password_confirmation.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar", style: textTheme.headline5),
      ),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Buat Akun", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                        Text("Daftar untuk memulai", style: textTheme.headline6),
                        SizedBox(height: 40),
                        InputIcon(hintText: "Nama", icon: Icons.person, controller: name),
                        SizedBox(height: 10),
                        InputIcon(hintText: "Email", icon: Icons.email, controller: email),
                        SizedBox(height: 10),
                        InputIcon(hintText: "Password", icon: Icons.lock, secure: true, controller: password),
                        SizedBox(height: 10),
                        InputIcon(hintText: "Konfirmasi Password", icon: Icons.lock, secure: true, controller: password_confirmation),
                        SizedBox(height: 10),
                        CheckboxListTile(
                          tileColor: Colors.white,
                          selectedTileColor: Colors.white,
                          contentPadding: EdgeInsets.all(0),
                          title: Text("Saya pemilik properti"),
                          value: isUser,
                          onChanged: (value) {
                            setState(() {
                              isUser = !isUser;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                        ),
                        SizedBox(height: 10),
                        Button(text: "Selanjutnya", color: primaryColor, onPressed: isLoading ? null : () => validateRegisterForm(context)),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Sudah punya akun ?", style: textTheme.subtitle1),
                            SizedBox(width: 5),
                            Link(
                              onTap: () => Navigator.pop(context),
                              text: "Masuk",
                              size: 14,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}