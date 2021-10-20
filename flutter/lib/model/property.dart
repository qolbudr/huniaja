class Property {
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
  String dateCreated;
  int priceDay;
  int priceMonth;
  int priceYear;
  int avgRating;
  int countFacility;
  String image;
  String ownerName;
  String email;
  String phone;

  Property(
      {this.id,
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
      this.avgRating,
      this.countFacility,
      this.image,
      this.ownerName,
      this.email,
      this.phone});

  Property.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ownerId = json['ownerId'];
    name = json['name'];
    description = json['description'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    avaliable = json['avaliable'];
    vrooms = json['vrooms'];
    dateCreated = json['date_created'];
    priceDay = json['price_day'];
    priceMonth = json['price_month'];
    priceYear = json['price_year'];
    avgRating = json['avg_rating'];
    countFacility = json['count_facility'];
    image = json['image'];
    ownerName = json['ownerName'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['ownerId'] = this.ownerId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['type'] = this.type;
    data['avaliable'] = this.avaliable;
    data['vrooms'] = this.vrooms;
    data['date_created'] = this.dateCreated;
    data['price_day'] = this.priceDay;
    data['price_month'] = this.priceMonth;
    data['price_year'] = this.priceYear;
    data['avg_rating'] = this.avgRating;
    data['count_facility'] = this.countFacility;
    data['image'] = this.image;
    data['ownerName'] = this.ownerName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}