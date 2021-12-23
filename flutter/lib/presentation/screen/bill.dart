import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/config/app.dart';
import 'package:lottie/lottie.dart';


class Bill extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Tagihan"),
            elevation: 0,
          ),
          body: FutureBuilder<dynamic>(
            future: ApiService().getBill(authLogin.authLogin.token, authLogin.authLogin.user.id.toString()),
            builder: (context, snapshot) {
              if(snapshot.data == null) {
                return LinearProgressIndicator(minHeight: 1);
              } else {
                var data = snapshot.data;
                return ListView.separated(
                  padding: EdgeInsets.all(15),
                  separatorBuilder: (context, index) => Divider(height: 0),
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    if(data.length > 0) {
                      return ListTile(
                        // isThreeLine: true,
                        tileColor: Colors.white,
                        subtitle: Text(data[index]['date'] + " # " + NumberFormat.compactCurrency(locale: 'ID').format(data[index]['price']), style: textTheme.subtitle2),
                        leading: Padding(
                          padding: const EdgeInsets.only(top: 3),
                          child: Icon(Icons.receipt, color: primaryColor),
                        ),
                        title: Text(data[index]['propertyName'], maxLines: 1),
                        trailing: data[index]['status'] == 1 ? Text("Lunas") : Text("Belum Lunas"),
                      );
                    } else {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.network('https://assets6.lottiefiles.com/packages/lf20_t24tpvcu.json'),
                            Text("Belum ada sewa", style: textTheme.headline6)
                          ]
                        )
                      );
                    }
                  }, 
                );
              }
            },
          )
        );
      },
    );
  }
}