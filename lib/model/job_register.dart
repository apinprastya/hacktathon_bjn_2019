import 'package:cloud_firestore/cloud_firestore.dart';

class JobRegister {
  final String id;
  final DateTime date;
  final String user;
  final String company;
  final String job;
  JobRegister({this.id, this.date, this.user, this.company, this.job});
  factory JobRegister.fromJson(Map<String, dynamic> json) {
    return JobRegister(
      id: json['id'],
      company: json['company'],
      date: (json['date'] as Timestamp).toDate(),
      job: json['job'],
      user: json['user'],
    );
  }

  toJson() {
    return {
      'id': id,
      'company': company,
      'date': Timestamp.fromDate(date),
      'job': job,
      'user': user,
    };
  }
}
