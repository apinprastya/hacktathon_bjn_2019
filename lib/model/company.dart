class CompanyModel {
  final String email;
  final String name;
  final String phone;
  final String address;

  CompanyModel({
    this.name,
    this.phone,
    this.address,
    this.email,
  });
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    return CompanyModel(
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      email: json['email'],
    );
  }

  toJson() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
    };
  }
}
