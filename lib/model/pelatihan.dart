import 'package:cloud_firestore/cloud_firestore.dart';

class PelatihanMasterModel {
  final String id;
  final String name;
  final String level; //Junior 1, Junior 2, Senior, Supervisor
  final String description;

  PelatihanMasterModel({this.id, this.name, this.level, this.description});
  factory PelatihanMasterModel.fromDocument(DocumentSnapshot doc) {
    return PelatihanMasterModel.fromJson(doc.data);
  }

  factory PelatihanMasterModel.fromJson(Map<String, dynamic> json) {
    return PelatihanMasterModel(
      id: json['id'],
      name: json['name'],
      level: json['level'],
      description: json['description'],
    );
  }

  copyWith({String id, String name, String level, String description}) {
    return PelatihanMasterModel(
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      description: description ?? this.description,
    );
  }

  toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'description': description,
    };
  }
}

class PelatihanScoreModel {
  final String email;
  final String score; //Kurang, Cukup, Baik, Sempurna
  PelatihanScoreModel({this.email, this.score});
  copyWith({String email, String score}) {
    return PelatihanScoreModel(
        email: email ?? this.email, score: score ?? this.score);
  }

  factory PelatihanScoreModel.fromJson(Map<String, dynamic> json) {
    return PelatihanScoreModel(email: json['email'], score: json['score']);
  }
}

class PelatihanModel {
  final PelatihanMasterModel master;
  final String place;
  final DateTime dateOpen;
  final DateTime dateClose;
  final DateTime date;
  final List<String> participants;
  final List<String> success;
  final List<PelatihanScoreModel> scores;
  PelatihanModel({
    this.master,
    this.place,
    this.dateOpen,
    this.dateClose,
    this.date,
    this.participants,
    this.success,
    this.scores,
  });
  factory PelatihanModel.fromDocument(DocumentSnapshot doc) {
    return PelatihanModel.fromJson(doc.data);
  }
  factory PelatihanModel.fromJson(Map<String, dynamic> json) {
    return PelatihanModel(
      date: (json['date'] as Timestamp).toDate(),
      dateClose: (json['date_close'] as Timestamp).toDate(),
      dateOpen: (json['date_open'] as Timestamp).toDate(),
      master: PelatihanMasterModel.fromJson(json['master']),
      participants: List<String>.from(json['participants']),
      success: List<String>.from(json['success']),
      scores: (json['scores'] as List).map(
          (v) => PelatihanScoreModel.fromJson(Map<String, dynamic>.from(v))),
    );
  }
}
