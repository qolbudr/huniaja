// To parse this JSON data, do
//
//     final locationItem = locationItemFromJson(jsonString);

import 'dart:convert';

LocationItem locationItemFromJson(String str) => LocationItem.fromJson(json.decode(str));

String locationItemToJson(LocationItem data) => json.encode(data.toJson());

class LocationItem {
    LocationItem({
        this.status,
        this.meta,
        this.data,
    });

    bool status;
    Meta meta;
    Data data;

    factory LocationItem.fromJson(Map<String, dynamic> json) => LocationItem(
        status: json["status"],
        meta: Meta.fromJson(json["meta"]),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "meta": meta.toJson(),
        "data": data.toJson(),
    };
}

class Data {
    Data({
        this.keyword,
        this.optimizedKeyword,
        this.areas,
        this.areaDataSource,
        this.landings,
        this.landingDataSource,
        this.rooms,
        this.roomDataSource,
    });

    String keyword;
    String optimizedKeyword;
    List<Area> areas;
    String areaDataSource;
    List<Landing> landings;
    String landingDataSource;
    List<Room> rooms;
    String roomDataSource;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        keyword: json["keyword"],
        optimizedKeyword: json["optimizedKeyword"],
        areas: List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
        areaDataSource: json["areaDataSource"],
        landings: List<Landing>.from(json["landings"].map((x) => Landing.fromJson(x))),
        landingDataSource: json["landingDataSource"],
        rooms: List<Room>.from(json["rooms"].map((x) => Room.fromJson(x))),
        roomDataSource: json["roomDataSource"],
    );

    Map<String, dynamic> toJson() => {
        "keyword": keyword,
        "optimizedKeyword": optimizedKeyword,
        "areas": List<dynamic>.from(areas.map((x) => x.toJson())),
        "areaDataSource": areaDataSource,
        "landings": List<dynamic>.from(landings.map((x) => x.toJson())),
        "landingDataSource": landingDataSource,
        "rooms": List<dynamic>.from(rooms.map((x) => x.toJson())),
        "roomDataSource": roomDataSource,
    };
}

class Area {
    Area({
        this.title,
        this.area,
        this.latitude,
        this.longitude,
        this.placeId,
    });

    String title;
    String area;
    double latitude;
    double longitude;
    String placeId;

    factory Area.fromJson(Map<String, dynamic> json) => Area(
        title: json["title"],
        area: json["area"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        placeId: json["place_id"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "area": area,
        "latitude": latitude,
        "longitude": longitude,
        "place_id": placeId,
    };
}

class Landing {
    Landing({
        this.title,
        this.slug,
        this.tags,
        this.coordinate,
        this.price,
        this.arrayPrice,
        this.gender,
        this.arrayGender,
    });

    String title;
    String slug;
    List<String> tags;
    List<List<double>> coordinate;
    Price price;
    List<int> arrayPrice;
    List<Gender> gender;
    List<int> arrayGender;

    factory Landing.fromJson(Map<String, dynamic> json) => Landing(
        title: json["title"],
        slug: json["slug"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        coordinate: List<List<double>>.from(json["coordinate"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        price: Price.fromJson(json["price"]),
        arrayPrice: List<int>.from(json["array_price"].map((x) => x)),
        gender: List<Gender>.from(json["gender"].map((x) => genderValues.map[x])),
        arrayGender: List<int>.from(json["array_gender"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "coordinate": List<dynamic>.from(coordinate.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "price": price.toJson(),
        "array_price": List<dynamic>.from(arrayPrice.map((x) => x)),
        "gender": List<dynamic>.from(gender.map((x) => genderValues.reverse[x])),
        "array_gender": List<dynamic>.from(arrayGender.map((x) => x)),
    };
}

enum Gender { CAMPUR, PUTRI, PUTRA }

final genderValues = EnumValues({
    "campur": Gender.CAMPUR,
    "putra": Gender.PUTRA,
    "putri": Gender.PUTRI
});

class Price {
    Price({
        this.min,
        this.max,
    });

    int min;
    int max;

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        min: json["min"],
        max: json["max"],
    );

    Map<String, dynamic> toJson() => {
        "min": min,
        "max": max,
    };
}

class Room {
    Room({
        this.title,
        this.slug,
        this.roomId,
        this.apartmentId,
        this.gender,
        this.propertyType,
        this.code,
    });

    String title;
    String slug;
    int roomId;
    int apartmentId;
    Gender gender;
    String propertyType;
    String code;

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        title: json["title"],
        slug: json["slug"],
        roomId: json["room_id"],
        apartmentId: json["apartment_id"] == null ? null : json["apartment_id"],
        gender: genderValues.map[json["gender"]],
        propertyType: json["property_type"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "slug": slug,
        "room_id": roomId,
        "apartment_id": apartmentId == null ? null : apartmentId,
        "gender": genderValues.reverse[gender],
        "property_type": propertyType,
        "code": code,
    };
}

class Meta {
    Meta({
        this.responseCode,
        this.code,
        this.severity,
        this.message,
    });

    int responseCode;
    int code;
    String severity;
    String message;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        responseCode: json["response_code"],
        code: json["code"],
        severity: json["severity"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "response_code": responseCode,
        "code": code,
        "severity": severity,
        "message": message,
    };
}

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
