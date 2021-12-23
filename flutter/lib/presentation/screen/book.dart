import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manpro/model/property.dart';
import 'package:manpro/model/user.dart';
import 'package:manpro/presentation/screen/message.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/select.dart';
import 'package:manpro/presentation/widget/timepicker.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/config/app.dart';
class Book extends StatefulWidget {
  @override
  Book(this.property);
  final Property property;
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  String type = "1";
  String checkInDay = DateTime.now().toLocal().toString();
  String checkOutDay = DateTime.now().add(Duration(days: 1)).toLocal().toString();
  final checkInDays = TextEditingController();
  final checkOutDays = TextEditingController();
  String diff;
  String monthDuration = "1";
  String yearDuration = "1";
  String monthTypePayment = "penuh";
  String yearTypePayment = "penuh";

  @override
  void dispose() {
    checkInDays.dispose();
    checkOutDays.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Pesan Hotel"),
            elevation: 0,
          ),
          body: FutureBuilder<User>(
            future: ApiService().getUserData(authLogin.authLogin.user.id.toString(), authLogin.authLogin.token),
            builder: (context, user) {
              if(user.data == null) {
                return LinearProgressIndicator(minHeight: 1);
              } else {
                return ListView(
                padding: EdgeInsets.all(15),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: accentColor, width: 2)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Saldo", style: textTheme.headline6),
                              SizedBox(height: 10),
                              Text("Saldo e-wallet anda")
                            ],
                          ),
                          Text(NumberFormat.compactCurrency(locale: 'ID').format(user.data.balance), style: textTheme.headline5),
                        ]
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text("Pembayaran", style: textTheme.headline5),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomRadioButton(
                        buttonTextStyle: ButtonTextStyle(
                          textStyle: textTheme.subtitle1
                        ),
                        height: 30,
                        elevation: 0,
                        enableButtonWrap: true,
                        autoWidth: true,
                        unSelectedColor: Theme.of(context).canvasColor,
                        buttonLables: [
                          if(widget.property.priceDay != null)
                            "Harian",
                          "Bulanan",
                          "Tahunan",
                        ],
                        buttonValues: [
                          if(widget.property.priceDay != null)
                            "0",
                          "1",
                          "2",
                        ],
                        radioButtonValue: (value) {
                          setState(() {
                            type = value;
                          });
                        },
                        defaultSelected: "1",
                        selectedColor: primaryColor,
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  if(type == "0")
                    if(widget.property.priceDay != null)
                      Column(
                        children: [
                          TimePicker(
                            controller: checkInDays,
                            initialDate: DateTime.parse(checkInDay),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            label: "Check In",
                            icon: Icons.calendar_today,
                            onChanged: (data) => setState(() {
                              checkInDay = data;
                              checkOutDay = DateTime.parse(data).add(Duration(days: 1)).toLocal().toString();
                              checkOutDays.text = "";
                              diff = null;
                            }),
                          ),
                          SizedBox(height: 10),
                          TimePicker(
                            controller: checkOutDays,
                            initialDate: DateTime.parse(checkOutDay),
                            firstDate: DateTime.parse(checkOutDay),
                            lastDate: DateTime(2100),
                            label: "Check Out",
                            icon: Icons.calendar_today,
                            onChanged: (data) => setState(() {
                              checkOutDay = data;
                              DateTime checkin = DateTime.parse(checkInDay);
                              DateTime checkout = DateTime.parse(checkOutDay);
                              diff = checkout.difference(checkin).inDays.toString();
                            }),
                          ),
                          SizedBox(height: 20),
                          Button(text: "Pesan", color: primaryColor, onPressed: diff == null ? null : () async {
                            try {
                              String data = await ApiService().payDay(authLogin.authLogin.token, authLogin.authLogin.user.id.toString(), widget.property.id.toString(), diff);
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) => Message(data)
                              ));
                            } catch(e) {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Message(e.toString())
                              ));
                            }
                          })
                        ],
                      ),

                  if(type == "1")
                    Column(
                      children: [
                        Select(
                          items: [
                            {"value": "1", "label": "1 Bulan"},
                            {"value": "2", "label": "2 Bulan"},
                            {"value": "3", "label": "3 Bulan"},
                            {"value": "4", "label": "4 Bulan"},
                            {"value": "5", "label": "5 Bulan"},
                            {"value": "6", "label": "6 Bulan"},
                            {"value": "7", "label": "7 Bulan"},
                            {"value": "8", "label": "8 Bulan"},
                            {"value": "9", "label": "9 Bulan"},
                            {"value": "10", "label": "10 Bulan"},
                            {"value": "11", "label": "11 Bulan"},
                            {"value": "12", "label": "12 Bulan"},
                          ],
                          currentSelectedValue: monthDuration,
                          text: "Bulan",
                          onChanged: (value) {
                            setState(() {
                              monthDuration = value;
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Select(
                          items: [
                            {"value": "penuh", "label": "Penuh"},
                            {"value": "cicil", "label": "$monthDuration x Bayar"}
                          ],
                          currentSelectedValue: monthTypePayment,
                          text: "Type Bayar",
                          onChanged: (value) {
                            setState(() {
                              monthTypePayment = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Button(text: "Pesan", color: primaryColor, onPressed: () async {
                          try {
                            var price = widget.property.discountPrice ?? widget.property.priceMonth;
                            String data = await ApiService().payMonth(authLogin.authLogin.token, authLogin.authLogin.user.id.toString(), widget.property.id.toString(), monthDuration, price.toString());
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => Message(data)
                            ));
                          } catch(e) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Message(e.toString())
                            ));
                          }
                        })
                      ],
                    ),

                  if(type == "2")
                    Column(
                      children: [
                        Select(
                          items: [
                            {"value": "1", "label": "1 Tahun"},
                            {"value": "2", "label": "2 Tahun"},
                          ],
                          currentSelectedValue: yearDuration,
                          text: "Tahun",
                          onChanged: (value) {
                            setState(() {
                              yearDuration = value;
                              yearTypePayment = "penuh";
                            });
                          },
                        ),
                        SizedBox(height: 10),
                        Select(
                          items: [
                            {"value": "penuh", "label": "Penuh"},
                            {"value": "${int.parse(yearDuration) * 6}", "label": "2X Bayar (Tiap ${int.parse(yearDuration) * 6} Bulan)"},
                            {"value": "${int.parse(yearDuration) * 4}", "label": "3X Bayar (Tiap ${int.parse(yearDuration) * 4} Bulan)"},
                            {"value": "${int.parse(yearDuration) * 3}", "label": "4X Bayar (Tiap ${int.parse(yearDuration) * 3} Bulan)"},
                            {"value": "${int.parse(yearDuration) * 2}", "label": "6X Bayar (Tiap ${int.parse(yearDuration) * 2} Bulan)"},
                            {"value": "${int.parse(yearDuration) * 1}", "label": "12X Bayar (Tiap ${int.parse(yearDuration) * 1} Bulan)"}
                          ],
                          currentSelectedValue: yearTypePayment,
                          text: "Type Bayar",
                          onChanged: (value) {
                            setState(() {
                              yearTypePayment = value;
                            });
                          },
                        ),
                        SizedBox(height: 20),
                        Button(text: "Pesan", color: primaryColor, onPressed: () async {
                          try {
                            double price = yearTypePayment == "penuh" ? widget.property.priceYear : widget.property.priceYear / (int.parse(yearDuration) * 12 / int.parse(yearTypePayment));
                            String data = await ApiService().payYear(authLogin.authLogin.token, authLogin.authLogin.user.id.toString(), yearDuration, widget.property.id.toString(), yearTypePayment, price.round().toString());
                            Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (context) => Message(data)
                            ));
                          } catch(e) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Message(e.toString())
                            ));
                          }
                        })
                      ],
                    ),
                  ] 
                );
              }
            }
          )
        );
      }
    );   
  }
}