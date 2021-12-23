import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/booking.dart';
import 'package:manpro/presentation/screen/message.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/card_hotel.dart';
import 'package:manpro/presentation/widget/select.dart';
import 'package:manpro/presentation/widget/textarea.dart';
import 'package:manpro/presentation/widget/snackbar.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/api_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/config/app.dart';
import 'package:lottie/lottie.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  TextEditingController reviewController = new TextEditingController();
  String rating;

  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, _, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Sewa"),
            elevation: 0
          ),
          body: ListView(
            padding: EdgeInsets.all(15),
            children: [
              FutureBuilder<BookingData>(
                future: ApiService().getBookingData(_.authLogin.token, _.authLogin.user.id),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CardHotelLoading();
                  } else {
                    if(snapshot.data == null) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.network('https://assets6.lottiefiles.com/packages/lf20_t24tpvcu.json'),
                            Text("Belum ada sewa", style: textTheme.headline6)
                          ]
                        )
                      );
                    } else {
                      BookingData data = snapshot.data;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CardHotelBooking(onTap: null, property: data.booking),
                          SizedBox(height: 20),
                          FutureBuilder(
                            future: ApiService().getReviewId(_.authLogin.token, _.authLogin.user.id, data.booking.id),
                            builder: (context, review) {
                              if(review.data == null) {
                                return SizedBox();
                              }
                              var reviews = review.data;
                              reviewController.text = reviews['review'];
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Rating", style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  Select(
                                    onChanged: (value) {
                                      setState(() {
                                        rating = value;
                                      });
                                    },
                                    currentSelectedValue: rating ?? '1',
                                    items: [
                                      {'value': '1', 'label': '1 Bintang'},
                                      {'value': '2', 'label': '2 Bintang'},
                                      {'value': '3', 'label': '3 Bintang'},
                                      {'value': '4', 'label': '4 Bintang'},
                                      {'value': '5', 'label': '5 Bintang'},
                                    ],
                                    text: "Review"
                                  ),
                                  SizedBox(height: 10),
                                  Text("Review", style: TextStyle(fontWeight: FontWeight.bold)),
                                  SizedBox(height: 10),
                                  TextArea(
                                    controller: reviewController,
                                    hintText: "Tulis Review", 
                                    hintSize: 16,
                                    transparency: 0
                                  ),
                                  SizedBox(height: 10),
                                  Button(
                                    color: primaryColor,
                                    text: "Simpan",
                                    onPressed: () async {
                                      try {
                                        rating = rating ?? reviews['rating'].toString();
                                        await ApiService().addReview(_.authLogin.token, _.authLogin.user.id, data.booking.id, reviewController.text, rating);
                                        showSnackbar(context, "Review berhasil ditambahkan");
                                        Navigator.pop(context);
                                      } catch(e) {
                                        showSnackbar(context, e.toString());
                                      }
                                    },
                                  )
                                ],
                              );
                            }
                          ),
                        ],
                      );
                    }
                  }
                },
              )
            ],
          ),
        );
      }
    );
  }
}