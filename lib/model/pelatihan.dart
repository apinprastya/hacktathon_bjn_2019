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
    if (json == null) return null;
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
  toJson() {
    return {
      'email': email,
      'score': score,
    };
  }
}

class PelatihanModel {
  final PelatihanMasterModel master;
  final String place;
  final DateTime dateOpen;
  final DateTime dateClose;
  final DateTime date;
  final int maxParticipant;
  final List<String> participants;
  final List<String> success;
  final List<PelatihanScoreModel> scores;
  PelatihanModel({
    this.master,
    this.place,
    this.dateOpen,
    this.dateClose,
    this.maxParticipant,
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
      date: json['date'] is DateTime
          ? json['date']
          : (json['date'] as Timestamp).toDate(),
      dateClose: json['date_close'] is DateTime
          ? json['date_close']
          : (json['date_close'] as Timestamp).toDate(),
      dateOpen: json['date_open'] is DateTime
          ? json['date_open']
          : (json['date_open'] as Timestamp).toDate(),
      maxParticipant: json['max_participant'] is String
          ? int.parse(json['max_participant'])
          : json['max_participant'],
      master: PelatihanMasterModel.fromJson(
          Map<String, dynamic>.from(json['master'])),
      participants: json['participants'] == null
          ? []
          : List<String>.from(json['participants']),
      success:
          json['success'] == null ? [] : List<String>.from(json['success']),
      scores: json['scores'] == null
          ? []
          : (json['scores'] as List)
              .map((v) =>
                  PelatihanScoreModel.fromJson(Map<String, dynamic>.from(v)))
              .toList(),
    );
  }
  copyWith({
    PelatihanMasterModel master,
    String place,
    DateTime dateOpen,
    DateTime dateClose,
    DateTime date,
    int maxParticipant,
    List<String> participants,
    List<String> success,
    List<PelatihanScoreModel> scores,
  }) {
    return PelatihanModel(
      master: master ?? this.master,
      place: place ?? this.place,
      dateOpen: dateOpen ?? this.dateOpen,
      dateClose: dateClose ?? this.dateClose,
      date: date ?? this.date,
      maxParticipant: maxParticipant ?? this.maxParticipant,
      participants: participants ?? this.participants,
      success: success ?? this.success,
      scores: scores ?? this.scores,
    );
  }

  toJson() {
    return {
      'date': Timestamp.fromDate(date),
      'date_open': Timestamp.fromDate(dateOpen),
      'date_close': Timestamp.fromDate(dateClose),
      'max_participant': maxParticipant,
      'master': master.toJson(),
      'participants': participants,
      'success': success,
      'scores': scores.map((v) => v.toJson()).toList(),
    };
  }
}
