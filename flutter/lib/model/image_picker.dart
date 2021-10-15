class ImagePicker {
  final String imageName;
  final String path;

  ImagePicker.fromJson(Map<String, dynamic> json)
  : imageName = json['imageName'],
  path= json['path'];

  Map<String, dynamic> toJson() => {
    'imageName': imageName,
    'path': path
  };
}