import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/presentation/screen/change_password.dart';
import 'package:manpro/presentation/screen/edit_profile.dart';
import 'package:manpro/presentation/screen/login.dart';
import 'package:manpro/presentation/screen/withdraw.dart';
import 'package:manpro/provider/auth.dart';
import 'package:provider/provider.dart';
import 'package:manpro/presentation/screen/income.dart';

class TabOwnerAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        return ListView(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_.authLogin.user.name, style: textTheme.headline5),
                      Text(_.authLogin.user.email, style: textTheme.subtitle1),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.logout),
                    onPressed: () {
                      _.logout();
                      return Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        }
                      ), (Route<dynamic> route) => false);
                    },
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              tileColor: Colors.white,
              title: Text("Profil"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => EditProfile()
              )),
            ),
            Divider(height: 0),
            ListTile(
              tileColor: Colors.white,
              title: Text("Pemasukan"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => Incomes() 
              )),
            ),
            Divider(height: 0),
            ListTile(
              tileColor: Colors.white,
              title: Text("Penarikan"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => Withdraw() 
              )),
            ),
            SizedBox(height: 10),
            ListTile(
              tileColor: Colors.white,
              title: Text("Ganti Password"),
              trailing: Icon(Icons.chevron_right),
              onTap: () => Navigator.push(context, MaterialPageRoute(
                builder: (context) => ChangePassword() 
              )),
            ),
            // Divider(height: 0),
            // ListTile(
            //   tileColor: Colors.white,
            //   title: Text("Hapus Akun", style: TextStyle(color: Colors.red)),
            //   onTap: () {},
            // ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("HuniAja - V1.0.0", style: textTheme.subtitle2)
              ],
            ),
          ],
        );
      }
    );
  }
}
