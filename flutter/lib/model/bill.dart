// To parse this JSON data, do
//
//final bill = billFromJson(jsonString);

import 'dart:convert';

List<Bill> billFromJson(String str) => List<Bill>.from(json.decode(str).map((x) => Bill.fromJson(x)));

String billToJson(List<Bill> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Bill {
    Bill({
        this.id,
        this.userId,
        this.propertyId,
        this.date,
        this.price,
        this.status,
        this.propertyName,
        this.userName,
    });

    int id;
    int userId;
    int propertyId;
    DateTime date;
    int price;
    int status;
    String propertyName;
    String userName;

    factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["id"],
        userId: json["userId"],
        propertyId: json["propertyId"],
        date: DateTime.parse(json["date"]),
        price: json["price"],
        status: json["status"],
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
        "propertyName": propertyName,
        "userName": userName,
    };
}
