import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/property.dart';
import 'package:manpro/model/review.dart';
import 'package:manpro/presentation/screen/chat_page.dart';
import 'package:manpro/presentation/widget/button.dart';
import 'package:manpro/presentation/widget/rating.dart';
import 'package:manpro/presentation/widget/squareicon.dart';
import 'package:manpro/provider/auth.dart';
import 'package:manpro/service/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:manpro/service/api_service.dart';
import 'package:manpro/model/hotel_photo.dart';
import 'package:manpro/presentation/widget/shimmer.dart';
import 'package:manpro/presentation/screen/book.dart';

class Detail extends StatefulWidget {
  @override
  Detail({this.property});
  final Property property;
  _DetailState createState() => _DetailState();

}

class _DetailState extends State<Detail> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthNotifier>(
      builder: (context, authLogin, child) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(widget.property.name),
            elevation: 0,
            actions: [
              IconButton(icon: Icon(Icons.favorite))
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ListView(
                      children: [
                        FutureBuilder<PropertyPhoto>(
                          future: ApiService().getPhoto(authLogin.authLogin.token, widget.property.id),
                          builder: (context, photo) {
                            if(photo.data == null) {
                              return Container(
                                width: double.infinity,
                                height: 200,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: [
                                    Image.network(
                                      apiURL + '/public/assets/images/' + widget.property.id.toString() + '-' + widget.property.name.replaceAll(' ', '-').toLowerCase() + '/' + widget.property.image, 
                                      // width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover
                                    ),
                                  ]
                                ),
                              );
                            } else {
                              List<Photo> data = photo.data.property;
                              return Container(
                                width: double.infinity,
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Image.network(
                                      apiURL + '/public/assets/images/' + widget.property.id.toString() + '-' + widget.property.name.replaceAll(' ', '-').toLowerCase() + '/' + data[index].image, 
                                      // width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.property.name, 
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, letterSpacing: 0.1, color: Colors.black),
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                              RatingStar(count: widget.property.avgRating),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.place, size: 14),
                                  SizedBox(width: 10),
                                  Text(widget.property.address)
                                ],
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text(
                                "Tentang", 
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.1, color: Colors.black),
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                              Text(widget.property.description, style: textTheme.subtitle1),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text(
                                "Fasilitas", 
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.1, color: Colors.black),
                                maxLines: 1,
                              ),
                              SizedBox(height: 10),
                              FutureBuilder(
                                future: ApiService().getPropertyFacility(authLogin.authLogin.token, widget.property.id),
                                builder: (context, facility) {
                                  if(facility.data == null) {
                                    return Row(
                                      children: List.generate(3, (index) => Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: ShimmerLoading(width: 80, height: 80),
                                      ))
                                    );
                                  } else {
                                    var data = facility.data["facility"];
                                    return Row(
                                      children: List.generate(data.length, (index) => Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: SquareIconFacility(icons: data[index]["webIcon"], text: data[index]["name"])
                                      ))
                                    );
                                  }
                                },
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text(
                                "Pemilik", 
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.1, color: Colors.black),
                                maxLines: 1,
                              ),
                              StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseService().getChatOwner(authLogin.authLogin.user.id, widget.property.ownerId),
                                builder: (context, chat) {
                                  if(chat.data == null) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(widget.property.ownerName, style: textTheme.headline6),
                                              SizedBox(height: 5),
                                              Text(widget.property.email),
                                            ],
                                          ),
                                          CircleIconButton(color: primaryColor, icon: Icons.chat)
                                        ]
                                      ),
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(widget.property.ownerName, style: textTheme.headline6),
                                              SizedBox(height: 5),
                                              Text(widget.property.email),
                                            ],
                                          ),
                                          if(authLogin.authLogin.user.role == 0)
                                            CircleIconButton(color: primaryColor, icon: Icons.chat, onPressed: () => Navigator.push(context, MaterialPageRoute(
                                              builder: (context) => ChatPage(ownerId: widget.property.ownerId, ownerName: widget.property.ownerName, chatId: "${widget.property.ownerId}:${authLogin.authLogin.user.id}",)
                                            )))
                                        ]
                                      ),
                                    );
                                  }
                                }
                              ),
                              SizedBox(height: 10),
                              Divider(),
                              SizedBox(height: 10),
                              Text(
                                "Review", 
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.1, color: Colors.black),
                                maxLines: 1,
                              ),
                              FutureBuilder<ReviewClass>(
                                future: ApiService().getReview(authLogin.authLogin.token, widget.property.id),
                                builder: (context, review) {
                                  if(review.data == null) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                      child: Column(
                                        children: List.generate(3, (index) => Column(
                                          children: [
                                            ShimmerLoading(width: 100, height: 15),
                                            SizedBox(height: 10),
                                            ShimmerLoading(width: 230, height: 15),
                                            SizedBox(height: 10),
                                            Divider()
                                          ]
                                        ))
                                      )
                                    );
                                  } else {
                                    List<Review> data = review.data.review;
                                    return Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                      child: Column(
                                        children: [
                                          Divider(),
                                          Column(
                                            children: List.generate(data.length, (index) => Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(data[index].name),
                                                SizedBox(height: 10),
                                                Text(data[index].review),
                                                Divider()
                                              ]
                                            ))
                                          ),
                                        ],
                                      )
                                    );
                                  }
                                },
                              ),
                              if(authLogin.authLogin.user.role == 0)
                                SizedBox(height: 100),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if(authLogin.authLogin.user.role == 0)
                      Positioned(
                        bottom: 0,
                        child: Container(
                          padding: EdgeInsets.all(15),
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Pesan Sekarang", style: textTheme.headline6),
                              ButtonEx(text: "Pesan", color: primaryColor, onPressed: () => Navigator.push(context, MaterialPageRoute(
                                builder: (context) => Book(widget.property)
                              )))
                            ],
                          )
                        ),
                      )
                  ],
                ),
              ),
            ],
          )
        );
      }
    );
  }
}