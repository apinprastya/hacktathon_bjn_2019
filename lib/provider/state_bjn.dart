import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/pelatihan.dart';

class StateBjn with ChangeNotifier {
  bool saving = false;
  bool init = false;
  Stream<QuerySnapshot> masterSnapshot;
  Stream<QuerySnapshot> pelatihanSnapshot;
  PelatihanMasterModel pelatihanMaster = PelatihanMasterModel();
  PelatihanModel pelatihan;
  bool pelatihanInit = false;

  Future<void> initMaster() async {
    if (init) return;
    init = true;
    masterSnapshot = Firestore.instance.collection('masters').snapshots();
  }

  Future<void> saveMaster() async {
    saving = true;
    notifyListeners();
    final ref = Firestore.instance.collection('masters').document();
    await ref.setData(pelatihanMaster.copyWith(id: ref.documentID).toJson());
    saving = false;
    notifyListeners();
  }

  Future<void> initPelatihan() async {
    if (pelatihanInit) return;
    pelatihanInit = true;
    pelatihanSnapshot = Firestore.instance.collection('pelatihans').snapshots();
  }

  Future<void> savePelatihan() async {
    saving = true;
    notifyListeners();
    final ref = Firestore.instance.collection('pelatihans').document();
    await ref.setData(pelatihan.copyWith(id: ref.documentID).toJson());
    saving = false;
    notifyListeners();
  }
}
