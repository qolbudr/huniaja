import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/user.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/input.dart';
import 'package:manpro/presentation/widget/snackbar.dart';
import 'package:manpro/presentation/widget/textarea.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';

class Withdraw extends StatefulWidget {
  @override
  _WithdrawState createState() => _WithdrawState();
}

class _WithdrawState extends State<Withdraw> {
  final penarikan = TextEditingController();
  final description = TextEditingController();
  String sisa;
  bool isEnabled = false;

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Penarikan"),
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
                  Text("Nominal Penarikan"),
                  SizedBox(height: 10),
                  Input(hintText: "Nominal Saldo", controller: penarikan, keyboardType: TextInputType.number, onChanged: (text) {
                    setState(() {
                      if(text == '') {
                        sisa = user.data.balance.toString();
                        isEnabled = false;
                      } else {
                        sisa = (user.data.balance -  int.parse(text)).toString();
                        if(int.parse(sisa).isNegative) {
                          isEnabled = false;
                          sisa = "Tidak bisa menarik saldo";
                        } else {
                          isEnabled = true;
                        }
                      }
                    });
                  }),
                  SizedBox(height: 10),
                  Input(hintText: sisa ?? user.data.balance.toString(), readOnly: true),
                  SizedBox(height: 10),
                  TextArea(hintText: 'Keterangan', controller: description),
                  SizedBox(height: 50),
                  Button(color: primaryColor, text: "Tarik Saldo", onPressed: isEnabled ? () async {
                    try {
                      await ApiService().requestWithdraw(_.authLogin.token, user.data.id, penarikan.text, description.text);
                      showSnackbar(context, "Penarikan berhasil menunggu persetujuan admin");
                      Navigator.pop(context);
                    } catch(e) {
                      showSnackbar(context, e.toString());
                    }
                  } : null),
                ]
              );
            }
          })
        );
      }
    );
  }
}