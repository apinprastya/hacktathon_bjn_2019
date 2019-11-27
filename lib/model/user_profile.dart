import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfileModel {
  final String name;
  final String address;
  final String desa;
  final String kecamatan;
  final String kabupaten;
  final String provinsi;
  final DateTime birthDate;
  final String birthPlace;
  final String gender;
  final String maritalStatus;
  final List<UserEducation> educations;

  UserProfileModel({
    this.name,
    this.address,
    this.desa,
    this.kecamatan,
    this.kabupaten,
    this.provinsi,
    this.gender,
    this.birthDate,
    this.birthPlace,
    this.maritalStatus,
    this.educations = const [],
  });

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
      maritalStatus: json['marital_status'],
      gender: json['gender'],
      birthDate: json['birth_date'] == null
          ? null
          : (json['birth_date'] as Timestamp).toDate(),
      birthPlace: json['birth_place'],
      educations: json['educations'] == null
          ? []
          : (json['educations'] as List).map((v) {
              return UserEducation.fromJson(Map<String, dynamic>.from(v));
            }).toList(),
    );
  }

  copyWith({
    String name,
    String address,
    String desa,
    String kecamatan,
    String kabupaten,
    String provinsi,
    String gender,
    String maritalStatus,
    String birthPlace,
    DateTime birthDate,
    List<UserEducation> educations,
  }) {
    return UserProfileModel(
      name: name ?? this.name,
      desa: desa ?? this.desa,
      kabupaten: kabupaten ?? this.kabupaten,
      address: address ?? this.address,
      kecamatan: kecamatan ?? this.kecamatan,
      provinsi: provinsi ?? this.provinsi,
      gender: gender ?? this.gender,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      birthPlace: birthPlace ?? this.birthPlace,
      birthDate: birthDate ?? this.birthDate,
      educations: educations ?? this.educations,
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
      'gender': gender,
      'marital_status': maritalStatus,
      'birth_place': birthPlace,
      'birth_date': birthDate == null ? null : Timestamp.fromDate(birthDate),
      'educations':
          educations.isEmpty ? [] : educations.map((v) => v.toJson()).toList(),
    };
  }
}

class UserEducation {
  final String level; //SD, SMP, SMA, D1, D2, D3, D4, S1, S2, S3
  final String name;
  final int year;

  UserEducation({
    this.name,
    this.year,
    this.level,
  });

  factory UserEducation.fromJson(Map<String, dynamic> json) {
    return UserEducation(
      name: json['name'],
      year: json['year'] is String ? int.parse(json['year']) : json['year'],
      level: json['level'],
    );
  }

  toJson() {
    return {
      'name': name,
      'year': year,
      'level': level,
    };
  }

  copyWith({
    String name,
    int year,
    String level,
  }) {
    return UserEducation(
      name: name ?? this.name,
      year: year ?? this.year,
      level: level ?? this.level,
    );
  }
}
