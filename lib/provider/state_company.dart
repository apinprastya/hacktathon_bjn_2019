import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/company.dart';
import 'package:merdhamel/model/jobs.dart';
import 'package:merdhamel/model/user.dart';

class StateCompany with ChangeNotifier {
  CompanyModel company;
  bool saving = false;
  Stream<QuerySnapshot> jobsSnapshot;
  bool jobInit = false;
  JobModel job;

  init() async {
    final d = await Firestore.instance
        .document('companies/${UserModel.instance.email}')
        .get();
    if (d.data == null)
      company = CompanyModel();
    else
      company = CompanyModel.fromJson(d.data);
    notifyListeners();
  }

  save() async {
    saving = true;
    notifyListeners();
    final ref =
        Firestore.instance.document('companies/${UserModel.instance.email}');
    await ref.setData(company.toJson(), merge: true);
    saving = false;
    notifyListeners();
  }

  initJob() async {
    if (jobInit) return;
    jobInit = true;
    jobsSnapshot = Firestore.instance
        .collection('jobs')
        .where('company.email', isEqualTo: UserModel.instance.email)
        .snapshots();
  }

  saveJob() async {
    saving = true;
    notifyListeners();
    final c = await Firestore.instance
        .document('companies/${UserModel.instance.email}')
        .get();
    final comp = CompanyModel.fromJson(c.data);
    final ref = Firestore.instance.collection('jobs').document();
    await ref.setData(job.copyWith(id: ref.documentID, company: comp).toJson());
    saving = false;
    notifyListeners();
  }
}
