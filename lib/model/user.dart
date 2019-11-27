import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static UserModel instance;
  final String id;
  final String email;
  final String name;
  final String address;
  final String type;
  UserModel({this.id, this.email, this.name, this.address, this.type});
  factory UserModel.fromDoc(DocumentSnapshot doc) {
    return UserModel.fromJson(doc.data);
  }
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      address: json['address'],
      type: json['type'],
    );
  }
  toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'address': address,
      'type': type,
    };
  }
}
