import 'package:flutter/material.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/presentation/widget/squareicon.dart';
import 'package:manpro/presentation/widget/card_hotel.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/list_property.dart';
import 'package:manpro/presentation/screen/detail.dart';

class TabHome extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return ListView(
          padding: EdgeInsets.all(15),
          children: [
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(5)
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Selamat Datang, ", style: textWhiteTheme.headline6),
                  SizedBox(height: 20),
                  Text("Pages that you view in this window won't appear in the browser history and they won't leave other traces, like cookies, on the.", style: textWhiteTheme.subtitle1),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text("Apa yang anda cari ?", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.25, color: Colors.black)),
            SizedBox(height: 20),
            Row(
              children: [
                SquareIcon(icon: Icons.home),
                SizedBox(width: 10),
                SquareIcon(icon: Icons.apartment),
                SizedBox(width: 10),
                SquareIcon(icon: Icons.hotel),
              ]
            ),
            SizedBox(height: 20),
            Text("Sewa Terpopuler", style: TextStyle(fontSize: 18, letterSpacing: 0.25, color: Colors.black)),
            SizedBox(height: 20),
            FutureBuilder<ListProperty>(
              future: ApiService().getListProperty(authLogin.authLogin.token),
              builder: (context, data) {
                if(data.data == null) {
                  return Column(
                    children: List.generate(1, 
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: CardHotelLoading(),
                      ) 
                    ),
                  );
                } else {
                  return Column(
                    children: List.generate(data.data.property.length, 
                      (index) => Padding( 
                          padding: EdgeInsets.only(bottom: 10),
                          child: CardHotel(
                          property: data.data.property[index], 
                          onTap: () => Navigator.push(context, MaterialPageRoute(
                            builder: (context) => Detail(property: data.data.property[index])
                          ))
                        )
                      ) 
                    ),
                  );
                }
              }
            ), 
          ],
        );
      },
    );
  }
}