class UserModel {
  String? id;
  String? phone;
  String? type;
  String? email;
  String? password;
  String? firstName; // New field for first name
  String? lastName; // New field for last name

  UserModel({
    this.id,
    this.phone,
    this.type,
    this.email,
    this.password,
    this.firstName,
    this.lastName,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    phone = json['phone'];
    type = json['type'];
    email = json['email'];
    password = json['password'];
    firstName = json['firstName']; // Assigning value for first name
    lastName = json['lastName']; // Assigning value for last name
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['phone'] = this.phone;
    data['type'] = this.type;
    data['email'] = this.email;
    data['password'] = this.password;
    data['firstName'] = this.firstName; // Adding value for first name
    data['lastName'] = this.lastName; // Adding value for last name
    return data;
  }
}
