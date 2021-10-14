import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/user.dart';
import 'package:manpro/presentation/screen/payment.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';

class Saldo extends StatefulWidget {
  @override
  _SaldoState createState() => _SaldoState();
}

class _SaldoState extends State<Saldo> {
  String nominal = "500000";

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Saldo"),
            elevation: 0,
          ),
          body: FutureBuilder<User>(
            future: ApiService().getUserData(_.authLogin.user.id.toString(), _.authLogin.token),
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
                  SizedBox(height: 15),
                  Text("Nominal Topup"),
                  SizedBox(height: 10),
                  Container(
                    height: 50,
                    child: ListView(
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
                                "500.000",
                                "1.000.000",
                                "5.000.000",
                                "10.000.000",
                              ],
                              buttonValues: [
                                "500000",
                                "1000000",
                                "5000000",
                                "10000000",
                              ],
                              radioButtonValue: (value) {
                                setState(() {
                                  nominal = value;
                                });
                              },
                              defaultSelected: "500000",
                              selectedColor: primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 50),
                  Button(color: primaryColor, text: "Topup", onPressed: () async {
                    String url = await ApiService().getPayURL(_.authLogin.token, _.authLogin.user.id, nominal);
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Payment(url: url)
                    ));
                  })
                ]
              );
            }
          })
        );
      }
    );
  }
}