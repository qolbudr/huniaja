// To parse this JSON data, do
//
//     final bookingData = bookingDataFromJson(jsonString);

import 'dart:convert';

BookingData bookingDataFromJson(String str) => BookingData.fromJson(json.decode(str));

String bookingDataToJson(BookingData data) => json.encode(data.toJson());

class BookingData {
    BookingData({
        this.message,
        this.booking,
    });

    String message;
    Booking booking;

    factory BookingData.fromJson(Map<String, dynamic> json) => BookingData(
        message: json["message"],
        booking: Booking.fromJson(json["booking"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "booking": booking.toJson(),
    };
}

class Booking {
    Booking({
        this.id,
        this.ownerId,
        this.name,
        this.description,
        this.address,
        this.latitude,
        this.longitude,
        this.type,
        this.avaliable,
        this.vrooms,
        this.dateCreated,
        this.priceDay,
        this.priceMonth,
        this.priceYear,
        this.userId,
        this.avgRating,
        this.date,
        this.status,
        this.image,
    });

    int id;
    int ownerId;
    String name;
    String description;
    String address;
    String latitude;
    String longitude;
    int type;
    int avaliable;
    dynamic vrooms;
    DateTime dateCreated;
    int priceDay;
    int priceMonth;
    int priceYear;
    int userId;
    int avgRating;
    DateTime date;
    int status;
    String image;

    factory Booking.fromJson(Map<String, dynamic> json) => Booking(
        id: json["id"],
        ownerId: json["ownerId"],
        name: json["name"],
        description: json["description"],
        address: json["address"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        type: json["type"],
        avaliable: json["avaliable"],
        vrooms: json["vrooms"],
        dateCreated: DateTime.parse(json["date_created"]),
        priceDay: json["price_day"],
        priceMonth: json["price_month"],
        priceYear: json["price_year"],
        userId: json["userId"],
        avgRating: json["avg_rating"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "ownerId": ownerId,
        "name": name,
        "description": description,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "type": type,
        "avaliable": avaliable,
        "vrooms": vrooms,
        "date_created": "${dateCreated.year.toString().padLeft(4, '0')}-${dateCreated.month.toString().padLeft(2, '0')}-${dateCreated.day.toString().padLeft(2, '0')}",
        "price_day": priceDay,
        "price_month": priceMonth,
        "price_year": priceYear,
        "userId": userId,
        "avg_rating": avgRating,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "status": status,
        "image": image,
    };
}
