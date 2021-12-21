import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'dart:convert';
import 'package:manpro/presentation/screen/login.dart';
import 'package:manpro/service/api_service.dart';

class Camera extends StatefulWidget {
  @override
  Camera(this.name, this.email, this.password, this.role);
  final String name, email, password, role;
  _CameraState createState() => _CameraState();
}

class _CameraState extends State<Camera> {
  CameraDescription camera;
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;

  void showCamera() async  {
    final cameras = await availableCameras();
    setState(() {
      camera = cameras[1];
      _cameraController = CameraController(camera, ResolutionPreset.medium);
      _initializeCameraControllerFuture = _cameraController.initialize();
    });
  }

  void _takePicture(_) async {
    try {
      final picture = await _cameraController.takePicture();
      final file = File(picture.path);
      List<int> imageBytes = file.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      String face = "data:image/jpeg;base64," + base64Image;
      registerUser(_, face);
    } catch (e) {
      print(e);
    }
  }

  void registerUser(_, face) async {
    try {
      String message = await ApiService().registerUser(widget.name, widget.email, widget.password, widget.role, face);
      final snackBar = SnackBar(
        content: Text(message),
        action: SnackBarAction(
          label: 'Oke',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(_).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Login()), (Route<dynamic> route) => false);
    } catch (e) {
      final snackBar = SnackBar(
        content: Text(e.toString()),
        action: SnackBarAction(
          label: 'Oke',
          onPressed: () {},
        ),
      );
      ScaffoldMessenger.of(_).showSnackBar(snackBar);
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Login()), (Route<dynamic> route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    showCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verifikasi Wajah", style: textTheme.headline5)
      ),
      body: Stack(children: <Widget>[
        FutureBuilder(
          future: _initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 30),
            child: CircleIconButton(
              icon: Icons.camera, 
              color: primaryColor, 
              size: 50, onPressed: () => _takePicture(context)
            ),
          )
        )
      ])
    );
  }
}