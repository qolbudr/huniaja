class User {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  String createdAt;
  String updatedAt;
  int role;
  String face;
  String dob;
  String address;
  String phone;
  int balance;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.createdAt,
      this.updatedAt,
      this.role,
      this.face,
      this.dob,
      this.address,
      this.phone,
      this.balance});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    role = json['role'];
    face = json['face'] ?? '';
    dob = json['dob'] ?? '';
    address = json['address'] ?? '';
    phone = json['phone'];
    balance = json['balance'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role'] = this.role;
    data['face'] = this.face;
    data['dob'] = this.dob;
    data['address'] = this.address;
    data['phone'] = this.phone;
    data['balance'] = this.balance;
    return data;
  }
}