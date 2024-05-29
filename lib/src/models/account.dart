class AccountModel {
  String? id;
  String? email;
  String? userName;
  String? firstName;
  String? lastName;
  String? gender;
  String? phone;
  String? address;
  String? role;

  AccountModel({
    this.id,
    this.email,
    this.userName,
    this.firstName,
    this.lastName,
    this.gender,
    this.phone,
    this.address,
    this.role,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'] as String?,
      email: json['email'] as String?,
      userName: json['userName'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      role: json['role'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'userName': userName,
      'firstName': firstName,
      'lastName': lastName,
      'gender': gender,
      'phone': phone,
      'address': address,
      'role': role,
    };
  }
}
