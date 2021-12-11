import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manpro/model/ImageProperty.dart';
import 'package:manpro/model/auth_login.dart';
import 'package:manpro/model/facilityProperty.dart';
import 'package:manpro/model/image_picker.dart';
import 'package:manpro/model/location_item.dart';
import 'package:manpro/model/propertyDetails.dart';
import 'package:manpro/model/propertyOwner.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:manpro/presentation/widget/link.dart';
import 'package:manpro/presentation/widget/select.dart';
import 'package:manpro/presentation/widget/snackbar.dart';
import 'package:manpro/presentation/widget/textarea.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/config/app.dart';
import '../location_picker.dart';

class EditProperty extends StatefulWidget {
  int propertyId;
  EditProperty({Key key, this.propertyId}) : super(key: key);

  @override
  _EditPropertyState createState() => _EditPropertyState();
}

class _EditPropertyState extends State<EditProperty> {
  PropertyDetails propertyDetails;
  bool isLoading = true;

  final name = TextEditingController();
  final description = TextEditingController();
  final address = TextEditingController();
  final virtualRoom = TextEditingController();
  final priceDaily = TextEditingController();
  final priceMonthly = TextEditingController();
  final priceYearly = TextEditingController();
  String latitude = "";
  String longitude = "";
  bool isUser = false;
  String _currentType = '0';
  AuthLogin auth;
  String path;

  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    name.dispose();
    description.dispose();
    address.dispose();
    virtualRoom.dispose();
    priceDaily.dispose();
    priceMonthly.dispose();
    priceYearly.dispose();
    super.dispose();
  }

  void updateLocation(Area area) {
    setState(() {
      latitude = area.latitude.toString();
      longitude = area.longitude.toString();
      address.text = area.title;
    });
  }

  void openLocationPicker(_) async {
    final location = await Navigator.push(
        _, MaterialPageRoute(builder: (_) => LocationPicker()));
    updateLocation(location);
  }

  void getDetails(String token) async {
    PropertyDetails property =
        await ApiService().getPropertyDetails(token, this.widget.propertyId);
    propertyDetails = property;
    setPropertyState();
  }

  void setPropertyState() {
    PropertyDetails property = this.propertyDetails;
    setState(() {
      isLoading = false;
      name.text = property.propertyOwner.name;
      description.text = property.propertyOwner.description;
      address.text = property.propertyOwner.address;
      virtualRoom.text = property.propertyOwner.vrooms;
      priceDaily.text = property.propertyOwner.priceDay.toString();
      priceMonthly.text = property.propertyOwner.priceMonth.toString();
      priceYearly.text = property.propertyOwner.priceYear.toString();
      _currentType = property.propertyOwner.type.toString();
      propertyDetails.img.imageProperty
          .add(ImageProperty(id: null, imageName: "Widget", propertyId: null));
      path = propertyDetails.img.path;
    });
  }

  void pickImage() async {
    try {
      XFile img = await _picker.pickImage(source: ImageSource.gallery);
      ImagePickerApp resImage = await ApiService().uploadImage(
          new File(img.path), auth.token, this.widget.propertyId, auth.user.id);
      ImageProperty newImg = ImageProperty(
          id: resImage.id,
          imageName: resImage.imageName,
          propertyId: this.widget.propertyId);
      setState(() {
        int latestIndex = propertyDetails.img.imageProperty.length - 1;
        propertyDetails.img.imageProperty.insert(latestIndex, newImg);
      });
    } catch (e) {}
  }

  void removeImage(imageProperty) async {
    int i = propertyDetails.img.imageProperty.indexOf(imageProperty);
    setState(() {
      propertyDetails.img.imageProperty.removeAt(i);
    });
    await ApiService().deleteImage(imageProperty.id.toString(), auth.token);
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

  Widget showImage() {
    return isLoading
        ? SizedBox()
        : CarouselSlider(
            items: propertyDetails.img.imageProperty.map((e) {
              return Builder(builder: (BuildContext context) {
                if (e.imageName == 'Widget') {
                  return addImagePicker();
                } else {
                  return Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: Image.network(
                            "${apiURL}/public/assets/images/${this.widget.propertyId}/${e.imageName}"),
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

  Widget facilitySelect() {
    return propertyDetails == null
        ? Container()
        : Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
                children: propertyDetails.facilityList
                    .map((facility) => CheckboxListTile(
                          title: Text(facility.name),
                          value: propertyDetails.facility
                              .where((element) =>
                                  element.facilityId == facility.facilityId)
                              .isNotEmpty,
                          secondary: Icon(IconData(facility.mobileIcon,
                              fontFamily: 'MaterialIcons')),
                          onChanged: (bool val) {
                            if (propertyDetails.facility
                                .where((element) =>
                                    element.facilityId == facility.facilityId)
                                .isNotEmpty) {
                              int i = propertyDetails.facility.indexWhere(
                                  (element) =>
                                      element.facilityId ==
                                      facility.facilityId);
                              setState(() {
                                propertyDetails.facility.removeAt(i);
                              });
                            } else {
                              setState(() {
                                propertyDetails.facility.add(FacilityProperty(
                                    facilityId: facility.facilityId,
                                    id: null,
                                    propertyId: this.widget.propertyId));
                              });
                            }
                            ApiService().triggerFacility(
                                facility.facilityId.toString(),
                                this.widget.propertyId.toString(),
                                auth.token,
                                auth.user.id.toString());
                          },
                        ))
                    .toList()));
  }

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, _, child) {
      AuthLogin login = _.authLogin;
      auth = login;
      if (propertyDetails == null) {
        getDetails(login.token);
      }
      var facilitySelect2 = facilitySelect();
      return Scaffold(
        appBar: AppBar(
          title: Text("Edit Property"),
          automaticallyImplyLeading: false,
          elevation: 0,
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, 1.0),
            child: isLoading ? LinearProgressIndicator() : SizedBox(),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Center(
                child: Link(
                    text: "Simpan",
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        await ApiService().updateProperty(
                          propertyId: this.widget.propertyId,
                          token: login.token,
                          userId: login.user.id,
                          name: name.text,
                          description: description.text,
                          address: address.text,
                          latitude: latitude,
                          longitude: longitude,
                          vrooms: virtualRoom.text,
                          priceMonth: priceMonthly.text,
                          priceYear: priceYearly.text,
                          priceDay: priceDaily.text,
                          type: _currentType,
                        );
                        setState(() {
                          isLoading = false;
                        });
                        return showSnackbar(context, "Berhasil Diperbarui");
                      } catch (e) {
                        return showSnackbar(context, e.toString());
                      }
                    }),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        showImage(),
                        SizedBox(height: 10),
                        Input(hintText: "Nama", controller: name),
                        SizedBox(height: 10),
                        TextArea(
                            hintText: "Deskripsi", controller: description),
                        SizedBox(height: 10),
                        Input(
                            hintText: "Alamat",
                            readOnly: true,
                            controller: address,
                            onTap: () => openLocationPicker(context)),
                        SizedBox(height: 10),
                        Input(
                            hintText: "Virtual Room", controller: virtualRoom),
                        SizedBox(height: 10),
                        Input(
                            hintText: "Harga (Harian)", controller: priceDaily),
                        SizedBox(height: 10),
                        Input(
                            hintText: "Harga (Bulanan)",
                            controller: priceMonthly),
                        SizedBox(height: 10),
                        Input(
                            hintText: "Harga (Tahunan)",
                            controller: priceYearly),
                        SizedBox(height: 10),
                        Select(
                          icon: Icons.hotel,
                          items: [
                            {'label': 'Rumah', 'value': '0'},
                            {'label': 'Apartemen', 'value': '1'},
                            {'label': 'Kontrakan', 'value': '2'},
                          ],
                          currentSelectedValue: _currentType,
                          text: "Tipe",
                          onChanged: (value) {
                            setState(() {
                              _currentType = value;
                            });
                          },
                        ),
                        facilitySelect()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
