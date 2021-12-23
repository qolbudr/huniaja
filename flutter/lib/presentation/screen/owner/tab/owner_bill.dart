import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/bill.dart';
import 'package:manpro/model/list_property.dart';
import 'package:manpro/presentation/widget/select.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';

class TabOwnerBill extends StatefulWidget {
  @override
  _TabOwnerBillState createState() => _TabOwnerBillState();
}

class _TabOwnerBillState extends State<TabOwnerBill> {
  String propertySelect;

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return FutureBuilder<ListProperty>(
          future: ApiService().getOwnerProperty(authLogin.authLogin.token, authLogin.authLogin.user.id.toString()),
          builder: (context, snapshot) {
            if(snapshot.data == null) {
              return LinearProgressIndicator(minHeight: 1);
            } else {
              var data = snapshot.data;
              var property = snapshot.data.property;
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Select(
                      items: List.generate(property.length, (index) {
                        return {'value': property[index].id.toString(), 'label': property[index].name };
                      }),
                      text: "Pilih Property",
                      onChanged: (value) {
                        setState(() {
                          propertySelect = value;
                        });
                      },
                      currentSelectedValue: propertySelect ?? null,
                    )
                  ),
                if(propertySelect != null)
                  Expanded(
                    child: FutureBuilder<List<Bill>>(
                      future: ApiService().getBillByPropertyId(propertySelect, authLogin.authLogin.token),
                      builder: (context, snapshots) {
                        if(snapshots.connectionState == ConnectionState.waiting) {
                          return SizedBox();
                        } else {
                          List<Bill> data = snapshots.data;
                          if(data.length > 0) {
                            return ListView.builder(
                              itemCount: data.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                                  padding: EdgeInsets.all(15),
                                  color: Colors.white,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(data[index].userName, style: textTheme.subtitle1, overflow: TextOverflow.ellipsis),
                                            SizedBox(height: 10),
                                            Text(data[index].date.toLocal().toString(), style: TextStyle(fontSize: 13, color: Colors.grey)),
                                            SizedBox(height: 10),
                                            if(data[index].status == 1)
                                              Container(
                                                color: Colors.green,
                                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                                child: Text("Lunas", style: textWhiteTheme.subtitle2)
                                              )
                                          ],
                                        ),
                                      ),
                                      Text(NumberFormat.simpleCurrency(locale: 'IDR', decimalDigits: 0).format(data[index].price), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                                    ],
                                  )
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.network('https://assets6.lottiefiles.com/packages/lf20_t24tpvcu.json'),
                                  Text("Belum ada tagihan", style: textTheme.headline6)
                                ]
                              )
                            );
                          }
                        }
                      },
                    ),
                  ),

                if(propertySelect == null)
                   Expanded(
                     child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Lottie.network('https://assets5.lottiefiles.com/packages/lf20_2qdetlxp.json', width: 200),
                          Text("Silahkan pilih property", style: textTheme.headline6)
                        ]
                      )
                    ),
                   ) 
                ]
              );
            }
          },
        );
      }
    );
  }
}