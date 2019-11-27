import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String name;
  final String address;
  final String desa;
  final String kecamatan;
  final String kabupaten;
  final String provinsi;

  UserProfileModel(
      {this.name,
      this.address,
      this.desa,
      this.kecamatan,
      this.kabupaten,
      this.provinsi});

  factory UserProfileModel.fromDocument(DocumentSnapshot doc) {
    return UserProfileModel.fromJson(doc.data);
  }

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    if (json == null) return UserProfileModel();
    return UserProfileModel(
      name: json['name'],
      address: json['address'],
      desa: json['desa'],
      kecamatan: json['kecamatan'],
      kabupaten: json['kabupaten'],
      provinsi: json['provinsi'],
    );
  }

  copyWith(
      {String name,
      String address,
      String desa,
      String kecamatan,
      String kabupaten,
      String provinsi}) {
    return UserProfileModel(
      name: name ?? this.name,
      desa: desa ?? this.desa,
      kecamatan: kecamatan ?? this.kecamatan,
      provinsi: provinsi ?? this.provinsi,
    );
  }

  toJson() {
    return {
      'name': name,
      'address': address,
      'desa': desa,
      'kecamatan': kecamatan,
      'kabupaten': kabupaten,
      'provinsi': provinsi,
    };
  }
}
