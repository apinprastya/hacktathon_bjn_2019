import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:merdhamel/model/company.dart';

class JobModel {
  final String id;
  final CompanyModel company;
  final DateTime dateClose;
  final String name;
  final String description;
  final String level;
  JobModel(
      {this.id,
      this.company,
      this.dateClose,
      this.name,
      this.description,
      this.level});

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['id'],
      company: json['company'] == null
          ? null
          : CompanyModel.fromJson(Map<String, dynamic>.from(json['company'])),
      dateClose: json['date_close'] is DateTime
          ? json['date_close']
          : (json['date_close'] as Timestamp).toDate(),
      name: json['name'],
      description: json['description'],
      level: json['level'],
    );
  }

  copyWith({
    String id,
    CompanyModel company,
    DateTime dateClose,
    String name,
    String description,
    String level,
  }) {
    return JobModel(
      id: id ?? this.id,
      company: company ?? this.company,
      dateClose: dateClose ?? this.dateClose,
      name: name ?? this.name,
      description: description ?? this.description,
      level: level ?? this.level,
    );
  }

  toJson() {
    return {
      'id': id,
      'company': company?.toJson(),
      'date_close': Timestamp.fromDate(dateClose),
      'name': name,
      'description': description,
      'level': level,
    };
  }
}
