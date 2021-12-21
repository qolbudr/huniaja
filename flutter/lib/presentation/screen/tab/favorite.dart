import 'package:flutter/material.dart';
import 'package:manpro/model/list_property.dart';
import 'package:manpro/presentation/screen/detail.dart';
import 'package:manpro/presentation/widget/card_hotel.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/provider/auth.dart';

class TabFavorite extends StatelessWidget {
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return FutureBuilder<ListProperty>(
          future: ApiService().getFavorite(authLogin.authLogin.token, authLogin.authLogin.user.id),
          builder: (context, favorite) {
            if(favorite.data == null) {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                children: List.generate(5, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CardHotelLoading(),
                ))
              );
            } else {
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: 15),
                children: List.generate(favorite.data.property.length, (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: CardHotel(
                    property: favorite.data.property[index],
                    onTap: () => Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Detail(property: favorite.data.property[index])
                    ))
                  ),
                ))
              );
            }
          }
        );
      }
    );
  }
}