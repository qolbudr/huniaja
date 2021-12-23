import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/owner_booking.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/rating.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class TabOwnerBooking extends StatefulWidget {
  @override
  _TabOwnerBookingState createState() => _TabOwnerBookingState();
}

class _TabOwnerBookingState extends State<TabOwnerBooking> {
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return FutureBuilder<OwnerListBook>(
          future: ApiService().getOwnerBooking(authLogin.authLogin.token, authLogin.authLogin.user.id.toString()),
          builder: (context, snapshot) {
            if(snapshot.data == null) {
              return LinearProgressIndicator(minHeight: 1);
            } else {
              var data = snapshot.data;
              var property = snapshot.data.booking.booking;
              if(data.booking.booking.length > 0) {
                return ListView.separated(
                  padding: EdgeInsets.all(15),
                  separatorBuilder: (context, index) => Divider(height: 0),
                  itemCount: data.booking.booking.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(property[index].name, style: textTheme.headline6, maxLines: 1),
                          SizedBox(height: 5),
                          RatingStar(count: property[index].avgRating ?? 0),
                          SizedBox(height: 5),
                          Text(property[index].description, style: textTheme.subtitle2, maxLines: 3),
                          SizedBox(height: 15),
                          if(data.booking.booking[index].status == 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonExSm(text: Icon(Icons.check), color: Colors.green, onPressed : () => {
                                  ApiService().confirmationBooking(authLogin.authLogin.token, data.booking.booking[index].bookingId, "accepted"),
                                }),
                                SizedBox(width: 5),
                                ButtonExSm(text: Icon(Icons.close), color: Colors.red, onPressed : () => ApiService().confirmationBooking(authLogin.authLogin.token, data.booking.booking[index].id, "deny"))
                              ],
                            ),
                          if(data.booking.booking[index].status == 1)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonExSm(text: Text("Diterima"), color: Colors.green, onPressed : () {}),
                              ],
                            ),
                          if(data.booking.booking[index].status == 2)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ButtonExSm(text: Text("Ditolak"), color: Colors.red, onPressed : () {}),
                              ],
                            ),
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
                      Text("Belum ada sewa", style: textTheme.headline6)
                    ]
                  )
                );
              }
            }
          },
        );
      }
    );
  }
}