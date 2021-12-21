// To parse this JSON data, do
//
//     final income = incomeFromJson(jsonString);

import 'dart:convert';

List<Income> incomeFromJson(String str) => List<Income>.from(json.decode(str).map((x) => Income.fromJson(x)));

String incomeToJson(List<Income> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Income {
    Income({
        this.id,
        this.userId,
        this.propertyId,
        this.date,
        this.price,
        this.status,
        this.bookingId,
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
        this.propertyName,
        this.userName,
    });

    int id;
    int userId;
    int propertyId;
    DateTime date;
    int price;
    int status;
    int bookingId;
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
    String propertyName;
    String userName;

    factory Income.fromJson(Map<String, dynamic> json) => Income(
        id: json["id"],
        userId: json["userId"],
        propertyId: json["propertyId"],
        date: DateTime.parse(json["date"]),
        price: json["price"],
        status: json["status"],
        bookingId: json["bookingId"],
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
        propertyName: json["propertyName"],
        userName: json["userName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "propertyId": propertyId,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "price": price,
        "status": status,
        "bookingId": bookingId,
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
        "propertyName": propertyName,
        "userName": userName,
    };
}
