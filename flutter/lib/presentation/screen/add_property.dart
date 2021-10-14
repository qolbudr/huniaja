import 'package:flutter/material.dart';
import 'package:manpro/model/auth_login.dart';
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

class AddProperty extends StatefulWidget {
  @override
  _AddPropertyState createState() => _AddPropertyState();
}

class _AddPropertyState extends State<AddProperty> {
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

  @override void dispose() {
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
      _, MaterialPageRoute(builder: (_) => LocationPicker())
    );
    updateLocation(location);
  }

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        AuthLogin login = _.authLogin;
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
                    }
                  ),
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
                          TextArea(hintText: "Deskripsi", controller: description),
                          SizedBox(height: 10),
                          Input(hintText: "Alamat", readOnly: true, controller: address, onTap: () => openLocationPicker(context)),
                          SizedBox(height: 10),
                          Input(hintText: "Virtual Room",  controller: virtualRoom),
                          SizedBox(height: 10),
                          Input(hintText: "Harga (Harian)", controller: priceDaily),
                          SizedBox(height: 10),
                          Input(hintText: "Harga (Bulanan)", controller: priceMonthly),
                          SizedBox(height: 10),
                          Input(hintText: "Harga (Tahunan)", controller: priceYearly),
                          SizedBox(height: 10),
                          Select(
                            icon: Icons.hotel,
                            items: [
                              {'label':'Rumah', 'value':'0'},
                              {'label':'Apartemen', 'value':'1'},
                              {'label':'Kontrakan', 'value':'2'},
                            ],
                            currentSelectedValue: _currentType,
                            text: "Tipe",
                            onChanged: (value) {
                              setState(() {
                                _currentType = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }
    );
  }
}