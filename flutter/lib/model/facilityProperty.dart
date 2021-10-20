class FacilityProperty {
  int id;
  int propertyId;
  int facilityId;

  FacilityProperty({this.facilityId, this.propertyId, this.id});

  FacilityProperty.fromJson(Map<String, dynamic> json) : 
  id = json['id'],
  propertyId = json['propertyId'],
  facilityId = json['facilityId'];
}