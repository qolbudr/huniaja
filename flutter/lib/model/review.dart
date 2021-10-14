import 'dart:convert';

ReviewClass reviewClassFromJson(String str) => ReviewClass.fromJson(json.decode(str));

String reviewClassToJson(ReviewClass data) => json.encode(data.toJson());

class ReviewClass {
    ReviewClass({
        this.message,
        this.review,
    });

    String message;
    List<Review> review;

    factory ReviewClass.fromJson(Map<String, dynamic> json) => ReviewClass(
        message: json["message"],
        review: List<Review>.from(json["review"].map((x) => Review.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "review": List<dynamic>.from(review.map((x) => x.toJson())),
    };
}

class Review {
    Review({
        this.id,
        this.userId,
        this.propertyId,
        this.review,
        this.rating,
        this.date,
        this.name,
    });

    int id;
    int userId;
    int propertyId;
    String review;
    int rating;
    DateTime date;
    String name;

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"],
        userId: json["userId"],
        propertyId: json["propertyId"],
        review: json["review"],
        rating: json["rating"],
        date: DateTime.parse(json["date"]),
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "propertyId": propertyId,
        "review": review,
        "rating": rating,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "name": name,
    };
}
