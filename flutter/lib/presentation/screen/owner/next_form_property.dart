import 'dart:io';
import 'package:manpro/config/app.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manpro/model/auth_login.dart';
import 'package:manpro/model/facility.dart';
import 'package:manpro/model/image_picker.dart';
import 'package:manpro/presentation/screen/owner/owner_home.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class NextFormProperty extends StatefulWidget {
  final int id;
  NextFormProperty({Key key, this.id}) : super(key: key);

  @override
  _NextFormPropertyState createState() => _NextFormPropertyState();
}

class _NextFormPropertyState extends State<NextFormProperty> {
  List<Facility> facilities;
  List<dynamic> imgList = ["Widget"];

  AuthLogin auth;

  XFile image;
  final ImagePicker _picker = ImagePicker();

  void getFacilities(token, AuthLogin login) async {
    List<Facility> facilitiesFromService =
        await ApiService().getFacility(token, login.user.id.toString());
    print(facilitiesFromService);
    setState(() {
      facilities = facilitiesFromService;
    });
  }

  void pickImage() async {
    try {
      XFile img = await _picker.pickImage(source: ImageSource.gallery);
      ImagePickerApp resImage = await ApiService().uploadImage(
          new File(img.path), auth.token, this.widget.id, auth.user.id);
      setState(() {
        int latestIndex = imgList.length - 1;
        imgList.insert(latestIndex, resImage);
      });
    } catch (e) {}
  }

  void removeImage(imageProperty) async {
    int i = imgList.indexOf(imageProperty);
    setState(() {
      imgList.removeAt(i);
    });
    await ApiService().deleteImage(imageProperty.id.toString(), auth.token);
  }

  Widget showImage() {
    return CarouselSlider(
        items: imgList.map((e) {
          return Builder(builder: (BuildContext context) {
            if (e == 'Widget') {
              return addImagePicker();
            } else {
              return Stack(
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Image.network(
                        "${apiURL}/public/assets/images/${e.path}/${e.imageName}"),
                  ),
                  Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                          onPressed: () {
                            removeImage(e);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.red,
                          )))
                ],
              );
            }
          });
        }).toList(),
        options: CarouselOptions(
            enlargeCenterPage: true, enableInfiniteScroll: false));
  }

  Widget showFacility() {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Text(
            "Fasilitas",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Column(
              children: facilities
                  .map((e) => CheckboxListTile(
                        secondary: Icon(IconData(e.mobileIcon,
                            fontFamily: 'MaterialIcons')),
                        title: Text(e.name),
                        value: e.isChecked,
                        onChanged: (bool value) {
                          setValue(e.facilityId, value);
                        },
                      ))
                  .toList()),
        ],
      ),
    );
  }

  Widget addImagePicker() {
    return InkWell(
      onTap: () {
        pickImage();
      },
      child: Container(
        child: Center(
          child: Icon(
            Icons.camera_alt,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }

  void setValue(int id, bool value) async {
    Facility f = facilities.where((f) => f.facilityId == id).toList()[0];
    int index = facilities.indexOf(f);
    setState(() {
      facilities[index].isChecked = value;
    });
    await ApiService().triggerFacility(f.facilityId.toString(),
        this.widget.id.toString(), auth.token, auth.user.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, _, child) {
      AuthLogin login = _.authLogin;
      auth = _.authLogin;
      if (facilities == null) {
        getFacilities(login.token, login);
      }
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Fasilitas Property"),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 1.0),
            child:
                (facilities == null ? LinearProgressIndicator() : Container()),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 15),
              child: Center(
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => OwnerHome()));
                    },
                    child: Text("Simpan")),
              ),
            )
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(20),
          children: [
            (imgList != null ? showImage() : Container()),
            (facilities == null ? Container() : showFacility())
          ],
        ),
      );
    });
  }
}
