import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/jobs.dart';
import 'package:merdhamel/page/company/recruitment/page_add_open.dart';
import 'package:merdhamel/provider/state_company.dart';
import 'package:merdhamel/widget/firestore_listview.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';

class PageOpenRecruitment extends StatefulWidget {
  @override
  _PageOpenRecruitmentState createState() => _PageOpenRecruitmentState();
}

class _PageOpenRecruitmentState extends State<PageOpenRecruitment> {
  @override
  void initState() {
    super.initState();
    Provider.of<StateCompany>(context, listen: false).initJob();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateCompany>(context);
    return ApScaffold(
      title: "Lowongan",
      body: FireStoreListView(
        snapshot: state.jobsSnapshot,
        itemBuilder: (BuildContext context, DocumentSnapshot document) {
          final d = JobModel.fromJson(document.data);
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
              context, MaterialPageRoute(builder: (c) => PageAddOpen()));
        },
      ),
    );
  }
}
