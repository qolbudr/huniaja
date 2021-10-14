// To parse this JSON data, do
//
//     final propertyPhoto = propertyPhotoFromJson(jsonString);

import 'dart:convert';

PropertyPhoto propertyPhotoFromJson(String str) => PropertyPhoto.fromJson(json.decode(str));

String propertyPhotoToJson(PropertyPhoto data) => json.encode(data.toJson());

class PropertyPhoto {
    PropertyPhoto({
        this.message,
        this.property,
    });

    String message;
    List<Photo> property;

    factory PropertyPhoto.fromJson(Map<String, dynamic> json) => PropertyPhoto(
        message: json["message"],
        property: List<Photo>.from(json["property"].map((x) => Photo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "property": List<dynamic>.from(property.map((x) => x.toJson())),
    };
}

class Photo {
    Photo({
        this.id,
        this.propertyId,
        this.image,
    });

    int id;
    int propertyId;
    String image;

    factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        propertyId: json["propertyId"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "propertyId": propertyId,
        "image": image,
    };
}
