import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/user_profile.dart';

class StateUser with ChangeNotifier {
  UserProfileModel userProfile;
  DocumentReference userRef;
  bool inited = false;

  Future<void> loadUserProfile() async {
    if (inited) return;
    final email = (await FirebaseAuth.instance.currentUser()).email;
    inited = true;
    userRef = Firestore.instance.document('profiles/$email');
    userRef.snapshots().listen((v) {
      userProfile = UserProfileModel.fromDocument(v);
      notifyListeners();
    });
  }

  Future<void> save() async {
    await userRef.setData(userProfile.toJson());
  }
}
