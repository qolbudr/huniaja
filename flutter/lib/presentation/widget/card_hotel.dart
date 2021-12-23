import 'package:flutter/material.dart';
import 'package:manpro/config/app.dart';
import 'package:manpro/model/booking.dart';
import 'package:manpro/model/property.dart';
import 'package:manpro/presentation/widget/badge.dart';
import 'package:manpro/presentation/widget/rating.dart';
import 'package:intl/intl.dart';
import 'package:manpro/presentation/widget/shimmer.dart';

class CardHotel extends StatelessWidget {
  CardHotel({this.onTap, this.property});

  final Property property;
  final void Function() onTap;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              apiURL + '/public/assets/images/' + property.id.toString() + '/' + property.image, 
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover
            )
          ),
          SizedBox(height: 10),
          Row(
            children: [
              if(property.priceDay != null)
                Badge(text: "Harian", color: primaryColor),

              if(property.priceMonth != null)
                Badge(text: "Bulanan", color: primaryColor),

              if(property.priceYear != null)
                Badge(text: "Tahunan", color: primaryColor),
            ]
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      property.name, 
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.1, color: Colors.black),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 5),
                    RatingStar(count: property.avgRating ?? 0),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.place, size: 14),
                        SizedBox(width: 5),
                        Text(property.address)
                      ],
                    )
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if(property.discountPrice != null)
                    Text(
                      NumberFormat.compactCurrency(locale: 'ID').format(property.priceMonth), 
                      style: TextStyle(fontSize: 12, letterSpacing: 0.1, color: Colors.black, decoration: TextDecoration.lineThrough),
                      maxLines: 1,
                    ),
                  Text(
                    NumberFormat.compactCurrency(locale: 'ID').format(property.discountPrice ?? property.priceMonth), 
                    style: TextStyle(fontSize: 17, letterSpacing: 0.1, color: Colors.black),
                    maxLines: 1,
                  ),
                  Text(
                    "per bulan",
                     style: TextStyle(fontSize: 10, letterSpacing: 0.1, color: Color(0xffbfbfbf)),
                  )
                ],
              )
            ],
          )
        ],
      )
    );
  }
}

class CardHotelBooking extends StatelessWidget {
  CardHotelBooking({this.onTap, this.property});

  final Booking property;
  final void Function() onTap;

  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              apiURL + '/public/assets/images/' + property.id.toString()  + '/' + property.image, 
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover
            )
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.name, 
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.1, color: Colors.black),
                    maxLines: 1,
                  ),
                  SizedBox(height: 5),
                  RatingStar(count: property.avgRating ?? 0),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.place, size: 14),
                      SizedBox(width: 5),
                      Text(property.address)
                    ],
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    NumberFormat.compactCurrency(locale: 'ID').format(property.priceMonth), 
                    style: TextStyle(fontSize: 20, letterSpacing: 0.1, color: Colors.black),
                    maxLines: 1,
                  ),
                  Text(
                    "per bulan",
                     style: TextStyle(fontSize: 14, letterSpacing: 0.1, color: Color(0xffbfbfbf)),
                  )
                ],
              )
            ],
          )
        ],
      )
    );
  }
}

class CardHotelLoading extends StatelessWidget {
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShimmerLoading(width: double.infinity, height: 200),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerLoading(width: 100, height: 15),
                SizedBox(height: 5),
                ShimmerLoading(width: 80, height: 15),
                SizedBox(height: 5),
                ShimmerLoading(width: 150, height: 15),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ShimmerLoading(width: 100, height: 15),
                SizedBox(height: 10),
                ShimmerLoading(width: 50, height: 15),
              ],
            )
          ],
        )
      ],
    );
  }
}