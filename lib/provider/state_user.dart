import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/job_register.dart';
import 'package:merdhamel/model/jobs.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/model/user.dart';
import 'package:merdhamel/model/user_profile.dart';
import 'package:merdhamel/model/usersession.dart';

class StateUser with ChangeNotifier {
  UserProfileModel userProfile;
  DocumentReference userRef;
  UserEducation userEducation;
  bool inited = false;
  bool saving = false;
  bool pelatihanInited = false;
  Stream<QuerySnapshot> pelatihanOpen;
  PelatihanModel pelatihan;
  Stream<QuerySnapshot> myPelatihan;
  Stream<QuerySnapshot> openJobs;
  JobModel jobModel;

  Future<void> loadUserProfile() async {
    if (inited) return;
    final email = UserSession.instance.user.email;
    inited = true;
    userRef = Firestore.instance.document('profiles/$email');
    userRef.snapshots().listen((v) {
      userProfile = UserProfileModel.fromDocument(v);
      notifyListeners();
    });
    myPelatihan = Firestore.instance
        .collection('pelatihans')
        .where('success', arrayContains: UserModel.instance.email)
        .snapshots();
  }

  Future<void> save() async {
    if (saving) return;
    saving = true;
    notifyListeners();
    print(userProfile.toJson());
    await userRef.setData(userProfile.toJson());
    saving = false;
    notifyListeners();
  }

  selectCurrentEducation(UserEducation edu) {
    userEducation = edu;
  }

  initPelatihan() async {
    if (pelatihanInited) return;
    pelatihanInited = true;
    pelatihanOpen = Firestore.instance
        .collection('pelatihans')
        .where('date_close', isGreaterThan: Timestamp.now())
        .snapshots();
  }

  joinPelatihan() async {
    final index =
        pelatihan.participants.indexWhere((v) => v == UserModel.instance.email);
    if (index >= 0) throw 'Anda sudah ada dalam pelatihan ini';
    saving = true;
    notifyListeners();
    final ref = Firestore.instance.document('pelatihans/${pelatihan.id}');
    pelatihan = pelatihan.copyWith(
        participants: List.from(pelatihan.participants)
          ..add(UserModel.instance.email));
    await ref.setData(pelatihan.toJson(), merge: true);
    saving = false;
    notifyListeners();
  }

  initOpenJob() {
    openJobs = Firestore.instance
        .collection('jobs')
        .where('date_close', isGreaterThan: Timestamp.now())
        .snapshots();
  }

  register() async {
    saving = true;
    notifyListeners();
    final reg = await Firestore.instance
        .collection('regs')
        .where('user', isEqualTo: UserModel.instance.email)
        .where('company', isEqualTo: jobModel.company.email)
        .getDocuments();
    if (reg.documents.isNotEmpty) {
      saving = false;
      notifyListeners();
      throw 'Anda sudah mendaftar pada lowongan ini';
    }
    final ref = Firestore.instance.collection('regs').document();
    final jr = JobRegister(
        user: UserModel.instance.email,
        job: jobModel.id,
        date: DateTime.now(),
        company: jobModel.company.email,
        id: ref.documentID);
    await ref.setData(jr.toJson());
    saving = false;
    notifyListeners();
  }
}
