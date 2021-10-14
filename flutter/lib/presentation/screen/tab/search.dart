import 'package:flutter/material.dart';
import 'package:manpro/presentation/screen/detail.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/presentation/widget/card_hotel.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/list_property.dart';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';

class TabSearch extends StatefulWidget {
  @override
  TabSearch({this.location = "Surabaya"});
  final String location;
  _TabSearchState createState() => _TabSearchState();
}

class _TabSearchState extends State<TabSearch> {
  String type = "undefined";
  String filter = "undefined";

  @override 
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return Column(
          children: [
            Container(
              width: double.infinity,
              height: 50,
              child: Center(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      children: [
                        CustomRadioButton(
                          buttonTextStyle: ButtonTextStyle(
                            textStyle: textTheme.subtitle1
                          ),
                          height: 30,
                          elevation: 0,
                          enableShape: true,
                          enableButtonWrap: true,
                          autoWidth: true,
                          unSelectedColor: Theme.of(context).canvasColor,
                          buttonLables: [
                            "Rumah",
                            "Kontrakan",
                            "Apartement",
                          ],
                          buttonValues: [
                            "0",
                            "1",
                            "2",
                          ],
                          radioButtonValue: (value) {
                            setState(() {
                              type = value;
                            });
                          },

                          selectedColor: primaryColor,
                        ),
                        CustomRadioButton(
                          buttonTextStyle: ButtonTextStyle(
                            textStyle: textTheme.subtitle1
                          ),
                          height: 30,
                          elevation: 0,
                          enableShape: true,
                          enableButtonWrap: true,
                          autoWidth: true,
                          unSelectedColor: Theme.of(context).canvasColor,
                          buttonLables: [
                            "Terbaru",
                            "Harga",
                            "Fasilitas",
                            "Rating",
                          ],
                          buttonValues: [
                            "newest",
                            "cheapest",
                            "facility",
                            "rating",
                          ],
                          radioButtonValue: (value) {
                            setState(() {
                              filter = value;
                            });
                          },

                          selectedColor: primaryColor,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(15),
                children: [
                  FutureBuilder<ListProperty>(
                    future: ApiService().getSearchFilter(authLogin.authLogin.token, widget.location, type, filter),
                    builder: (context, data) {
                      if(data.data == null) {
                        return Column(
                          children: List.generate(5, 
                            (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: CardHotelLoading(),
                            ) 
                          ),
                        );
                      } else {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Ditemukan ${data.data.property.length} properti di sekitar ${widget.location}", style: TextStyle(fontSize: 15, letterSpacing: 0.25, color: Colors.black)),
                            SizedBox(height: 20),
                            Column(
                              children: List.generate(data.data.property.length, 
                                (index) => CardHotel(
                                  property: data.data.property[index], 
                                  onTap: () => Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => Detail(property: data.data.property[index])
                                  )) 
                                ) 
                              ),
                            ),
                          ],
                        );
                      }
                    }
                  ), 
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}