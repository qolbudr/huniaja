import 'package:manpro/model/property.dart';

class ListProperty {
  String message;
  List<Property> property;

  ListProperty({this.message, this.property});

  ListProperty.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    if (json['property'] != null) {
      property = new List<Property>();
      json['property'].forEach((v) {
        property.add(new Property.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.property != null) {
      data['property'] = this.property.map((v) => v.toJson()).toList();
    }
    return data;
  }
}