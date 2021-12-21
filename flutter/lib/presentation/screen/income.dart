import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/model/income.dart';

class Incomes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Pemasukan"),
            elevation: 0,
          ),
          body: FutureBuilder<List<Income>>(
            future: ApiService().getIncome(_.authLogin.token, _.authLogin.user.id),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting) {
                return LinearProgressIndicator(minHeight: 1);
              } else {
                List<Income> data  = snapshot.data;
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
                                Text(data[index].name, style: textTheme.headline6, overflow: TextOverflow.ellipsis)
                              ],
                            ),
                          ),
                          Text(NumberFormat.simpleCurrency(locale: 'IDR', decimalDigits: 0).format(data[index].price), style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      )
                    );
                  },
                );
              }
            }
          )
        );
      }
    );
  }
}
