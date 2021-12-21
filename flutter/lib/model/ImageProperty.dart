class ImageProperty {
  int id;
  int propertyId;
  String imageName;

  ImageProperty({this.id,this.propertyId, this.imageName});

  ImageProperty.fromJson(Map<String, dynamic> json):
  id = json['id'],
  propertyId = json['propertyId'],
  imageName = json['image'];
}