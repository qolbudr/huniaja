class ImagePickerApp {
  final String imageName;
  final String path;
  final int id;

  ImagePickerApp.fromJson(Map<String, dynamic> json)
  : imageName = json['imageName'],
  path= json['path'],
  id = json['id'];

  Map<String, dynamic> toJson() => {
    'imageName': imageName,
    'path': path,
    'id': id
  };
}