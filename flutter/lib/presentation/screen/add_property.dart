import 'package:flutter/material.dart';
import 'package:manpro/model/auth_login.dart';
import 'package:manpro/model/facility.dart';
import 'package:manpro/model/location_item.dart';
import 'package:manpro/presentation/screen/owner/location_picker.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:manpro/presentation/widget/link.dart';
import 'package:manpro/presentation/widget/select.dart';
import 'package:manpro/presentation/widget/textarea.dart';
import 'package:manpro/presentation/widget/snackbar.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
  AuthLogin currentAuth;

final ImagePicker _picker = ImagePicker();

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
  bool isLoading = false;
  String _currentType = '0';

  List<Facility> facilities;

  XFile image;

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

  void getFacilities(token, AuthLogin login) async {
    List<Facility> facilitiesFromService =
        await ApiService().getFacility(token, login.user.id.toString());
    setState(() {
      facilities = facilitiesFromService;
    });
  }

  void pickImage()async {
    XFile img = await _picker.pickImage(source: ImageSource.gallery);
    print(img.path);
    setState(() {
      image = img;
    });
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

  Widget addImagePicker(){
    return GestureDetector(
      onTap: (){
        print("hit");
        pickImage();
      },
      child: Container(
        margin: EdgeInsets.only(
          top: 20
        ),
        height: MediaQuery.of(context).size.height * 0.2,
        
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(width: 3.0, color: Colors.blue),
          borderRadius: BorderRadius.circular(10.0)
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.add, color: Colors.blue,),
              Text("Tambahkan Foto", style: TextStyle(
                color: Colors.blue
              ),)
            ],
          ),
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

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(builder: (context, _, child) {
      AuthLogin login = _.authLogin;
      if (facilities == null) {
        getFacilities(login.token, login);
      }
      return Scaffold(
        appBar: AppBar(
          title: Text("Tambah Property"),
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
                        final data = await ApiService().insertProperty(
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
                        SizedBox(height: 10),
                        Input(hintText: "Nama", controller: name),
                        SizedBox(height: 10),
                        TextArea(
                            hintText: "Deskripsi", controller: description),
                        SizedBox(height: 10),
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
                        ((facilities != null) ? showFacility() : Container(
                          padding: EdgeInsets.only(top: 30),
                          child: CircularProgressIndicator(),
                        )),
                        addImagePicker()
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
