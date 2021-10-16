import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manpro/model/auth_login.dart';
import 'package:manpro/model/facility.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EditProperty extends StatefulWidget {
  // EditProperty({Key? key}) : super(key: key);

  @override
  _EditPropertyState createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  List<Facility> facilities;
  List<dynamic> imgList = ["Widget"];

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
      print(img.path);
      setState(() {
        int latestIndex = imgList.length - 1;
        imgList.insert(latestIndex, img.path);
      });
    } catch (e) {}
  }

  Widget showImage() {
    return CarouselSlider(
        items: imgList.map((e) {
          return Builder(builder: (BuildContext context) {
            if(e == 'Widget'){
              return addImagePicker();
            }else{
            return Container(
              child: Image.file(new File(e)),
            );
            }
          });
        }).toList(),
        options: CarouselOptions(
          enlargeCenterPage: true,
          enableInfiniteScroll: false
        ));
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
      onTap: (){
        pickImage();
      },
      child: Container(
        child: Center(
          child: Icon(Icons.camera_alt, color: Colors.blue,),
        ),
      ),
    );
  }

  void setValue(int id, bool value) {
    Facility f = facilities.where((f) => f.facilityId == id).toList()[0];
    int index = facilities.indexOf(f);
    setState(() {
      facilities[index].isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, _, child) {
      AuthLogin login = _.authLogin;
      if (facilities == null) {
        getFacilities(login.token, login);
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit"),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 1.0),
            child:
                (facilities == null ? LinearProgressIndicator() : Container()),
          ),
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
