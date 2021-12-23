import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:manpro/model/auth_login.dart';
import 'package:manpro/presentation/widget/link.dart';
import 'package:manpro/service/api_service.dart';
import 'package:manpro/presentation/widget/snackbar.dart';
import 'package:manpro/presentation/screen/owner/next_form_property.dart';

class Ownership extends StatefulWidget {
	final int id;
  Ownership({Key key, this.id}) : super(key: key);

  @override
  _OnwershipState createState() => _OnwershipState();
}

class _OnwershipState extends State<Ownership> {
  AuthLogin auth;
  File ownerProof;
  String fileName;

  void uploadFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path);
      setState(() {
        ownerProof = file;
        fileName = result.files.single.name;
      });
    }
  }

	@override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, _, child) {
      AuthLogin login = _.authLogin;
      auth = _.authLogin;
      return Scaffold(
        appBar: AppBar(
          title: Text("Upload Bukti Kepemilikan"),
          automaticallyImplyLeading: false,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Center(
                child: Link(
                  text: "Selanjutnya",
                  onTap: () async {
                    try {
                      await ApiService().uploadOwnership(ownerProof, auth.token, widget.id, auth.user.id);
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => NextFormProperty(id: widget.id)));
                    } catch (e) {
                      return showSnackbar(context, e.toString());
                    }
                  }
                ),
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            InkWell(
              onTap: () => uploadFile(),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black)
                ),
                child: Center(
                  child: Icon(Icons.upload_file)
                )
              ),
            ),
            SizedBox(height: 20),
            if(fileName != null)
              Container(
                color: primaryColor,
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Text(fileName, style: textWhiteTheme.headline6)
              )
          ],
        ),
      );
    });
  }
}