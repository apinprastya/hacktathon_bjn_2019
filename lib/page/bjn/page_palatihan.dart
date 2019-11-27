import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/page/bjn/page_add_pelatihan.dart';
import 'package:merdhamel/provider/state_bjn.dart';
import 'package:merdhamel/widget/firestore_listview.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';

class PagePelatihan extends StatefulWidget {
  @override
  _PagePelatihanState createState() => _PagePelatihanState();
}

class _PagePelatihanState extends State<PagePelatihan> {
  @override
  void initState() {
    super.initState();
    Provider.of<StateBjn>(context, listen: false).initPelatihan();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateBjn>(context);
    return ApScaffold(
      title: "Pelatihan",
      body: FireStoreListView(
        snapshot: state.pelatihanSnapshot,
        itemBuilder: (BuildContext context, DocumentSnapshot document) {
          final d = PelatihanModel.fromDocument(document);
          return ListTile(
            title: Text(d.master.name),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => PageAddPelatihan()));
        },
      ),
    );
  }
}
