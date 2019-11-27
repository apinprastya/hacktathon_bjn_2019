import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/page/bjn/page_add_master.dart';
import 'package:merdhamel/provider/state_bjn.dart';
import 'package:merdhamel/widget/firestore_listview.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';

class PageBjn extends StatefulWidget {
  @override
  _PageBjnState createState() => _PageBjnState();
}

class _PageBjnState extends State<PageBjn> {
  @override
  void initState() {
    super.initState();
    Provider.of<StateBjn>(context, listen: false).initMaster();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateBjn>(context);
    return ApScaffold(
      title: "Master Pelatihan",
      body: FireStoreListView(
        snapshot: state.masterSnapshot,
        itemBuilder: (BuildContext context, DocumentSnapshot document) {
          final d = PelatihanMasterModel.fromDocument(document);
          return ListTile(
            title: Text(d.name),
            subtitle: Text(d.level),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => PageAddMaster()));
        },
      ),
    );
  }
}
