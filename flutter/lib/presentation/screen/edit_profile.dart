import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/user.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/timepicker.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/presentation/widget/input.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController nameController, emailController, dobController, addressController, phoneController;

  void initState() {
    final AuthNotifier auth = Provider.of<AuthNotifier>(context, listen: false);
    super.initState();
    nameController = TextEditingController(text: auth.authLogin.user.name);
    emailController = TextEditingController(text: auth.authLogin.user.email);
    dobController = TextEditingController(text: auth.authLogin.user.dob);
    addressController = TextEditingController(text: auth.authLogin.user.address);
    phoneController = TextEditingController(text: auth.authLogin.user.phone);
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    addressController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Profil"),
            elevation: 0,
          ),
          body: ListView(
            padding: EdgeInsets.all(15),
            children: [
              Text("Nama Lengkap"),
              SizedBox(height: 10),
              Input(controller: nameController, hintText: "Nama Lengkap"),
              SizedBox(height: 10),
              Text("Email"),
              SizedBox(height: 10),
              Input(controller: emailController, hintText: "Email"),
              SizedBox(height: 10),
              Text("Tanggal Lahir"),
              SizedBox(height: 10),
              TimePicker(
                controller: dobController,
                initialDate: DateTime.parse(dobController.text == '' ? '2000-01-01' : dobController.text),
                label: "Tanggal Lahir",
                firstDate: DateTime(1960),
                lastDate: DateTime(2003),
                icon: Icons.calendar_today,
                onChanged: (data) => setState(() {
                  dobController.text = data;
                }),
              ),
              SizedBox(height: 10),
              Text("Alamat"),
              SizedBox(height: 10),
              Input(controller: addressController, hintText: "Alamat"),
              SizedBox(height: 10),
              Text("Telepon"),
              SizedBox(height: 10),
              Input(controller: phoneController, hintText: "Telepon"),
              SizedBox(height: 20),
              ButtonEx(color: primaryColor, text: "Simpan", onPressed: () async {
                try {
                  User user = await ApiService().updateUser(
                    _.authLogin.token,
                    _.authLogin.user.id.toString(),
                    nameController.text,
                    emailController.text,
                    dobController.text,
                    addressController.text,
                    phoneController.text
                  );

                  await _.updateUser(user);

                  final snackBar = SnackBar(
                    content: Text("Profil berhasil diupdate"),
                    action: SnackBarAction(
                      label: 'Oke',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  Navigator.pop(context);

                } catch (e) {
                  final snackBar = SnackBar(
                    content: Text(e.toString()),
                    action: SnackBarAction(
                      label: 'Oke',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              }),
            ]
          )
        );
      }
    );
  }
}