import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/user_profile.dart';
import 'package:merdhamel/model/usersession.dart';

class StateUser with ChangeNotifier {
  UserProfileModel userProfile;
  DocumentReference userRef;
  UserEducation userEducation;
  bool inited = false;
  bool saving = false;

  Future<void> loadUserProfile() async {
    if (inited) return;
    final email = UserSession.instance.user.email;
    inited = true;
    userRef = Firestore.instance.document('profiles/$email');
    userRef.snapshots().listen((v) {
      userProfile = UserProfileModel.fromDocument(v);
      notifyListeners();
    });
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
}
