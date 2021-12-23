// To parse this JSON data, do
//
//     final ownerListBook = ownerListBookFromJson(jsonString);

import 'dart:convert';

OwnerListBook ownerListBookFromJson(String str) => OwnerListBook.fromJson(json.decode(str));

String ownerListBookToJson(OwnerListBook data) => json.encode(data.toJson());

class OwnerListBook {
    OwnerListBook({
        this.message,
        this.booking,
    });

    String message;
    OwnerListBookBooking booking;

    factory OwnerListBook.fromJson(Map<String, dynamic> json) => OwnerListBook(
        message: json["message"],
        booking: OwnerListBookBooking.fromJson(json["booking"]),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "booking": booking.toJson(),
    };
}

class OwnerListBookBooking {
    OwnerListBookBooking({
        this.booking,
    });

    List<BookingElement> booking;

    factory OwnerListBookBooking.fromJson(Map<String, dynamic> json) => OwnerListBookBooking(
        booking: List<BookingElement>.from(json["booking"].map((x) => BookingElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "booking": List<dynamic>.from(booking.map((x) => x.toJson())),
    };
}

class BookingElement {
    BookingElement({
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
        this.bookingId
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
    int bookingId;
    String image;

    factory BookingElement.fromJson(Map<String, dynamic> json) => BookingElement(
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
        bookingId: json["bookingId"],
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
        "bookingId": bookingId,
    };
}
