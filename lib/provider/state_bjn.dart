import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/pelatihan.dart';

class StateBjn with ChangeNotifier {
  bool saving = false;
  bool init = false;
  Stream<QuerySnapshot> masterSnapshot;
  PelatihanMasterModel pelatihanMaster = PelatihanMasterModel();

  Future<void> initMaster() async {
    if (init) return;
    init = true;
    masterSnapshot = Firestore.instance.collection('masters').snapshots();
  }

  saveMaster() async {
    saving = true;
    notifyListeners();
    final ref = Firestore.instance.collection('masters').document();
    await ref.setData(pelatihanMaster.copyWith(id: ref.documentID).toJson());
    saving = false;
    notifyListeners();
  }
}
