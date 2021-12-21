class Facility {
  final int facilityId;
  final String name;
  final String webIcon;
  final int mobileIcon;
  bool isChecked;

  Facility.fromJson(Map<String, dynamic> json)
  : facilityId = json['id'],
  name = json['name'],
  webIcon = json['webIcon'],
  mobileIcon = int.parse(json['mobileIcon']),
  isChecked = false;

  Map<String, dynamic> toJson() => {
    'facilityId': facilityId,
    'name': name,
    'webIcon': webIcon,
    'mobileIcon': mobileIcon,
    'isChecked': isChecked
  };
}