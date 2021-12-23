import 'package:flutter/foundation.dart';

class PropertyOwner {
  int id;
  int ownerId;
  String name;
  String description;
  String address;
  String latitude;
  String longitude;
  int type;
  int avaliable;
  String vrooms;
  int priceDay;
  int priceMonth;
  int priceYear;
  int totalRoom;
  int discountPrice;

  PropertyOwner.fromJson(Map<String, dynamic> json):
  id = json['id'],
  name = json['name'],
  ownerId = json['ownerId'],
  description = json['description'],
  address = json['address'],
  latitude = json['latitude'],
  longitude = json['longitude'],
  type = json['type'],
  avaliable = json['avaliable'],
  vrooms = json['vrooms'],
  priceDay = json['price_day'],
  totalRoom = json['total_rooms'],
  priceMonth = json['price_month'],
  priceYear = json['price_year'],
  discountPrice = json['discount_price'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'ownerId': ownerId,
    'description': description,
    'address': address,
    'latitude': latitude,
    'longitude': longitude,
    'type': type,
    'avaliable': avaliable,
    'vrooms': vrooms,
    'price_daily': priceDay,
    'total_rooms': totalRoom,
    'price_monthly': priceMonth,
    'price_yearly': priceYear,
    'discount_price': discountPrice,
  };
}