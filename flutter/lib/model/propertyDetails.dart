

import 'package:manpro/model/ImageProperty.dart';
import 'package:manpro/model/facility.dart';
import 'package:manpro/model/facilityProperty.dart';
import 'package:manpro/model/propertyOwner.dart';

class Images {
  String path;
  List<ImageProperty> imageProperty;

  Images({this.path, this.imageProperty});
}

class PropertyDetails {
  PropertyOwner propertyOwner;
  List<Facility> facilityList;
  List<FacilityProperty> facility;
  Images img;

  PropertyDetails({this.propertyOwner, this.facility, this.facilityList, this.img});
}