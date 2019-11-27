import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/jobs.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/util.dart';
import 'package:merdhamel/widget/firestore_listview.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';

class PageUserJob extends StatefulWidget {
  @override
  _PageUserJobState createState() => _PageUserJobState();
}

class _PageUserJobState extends State<PageUserJob> {
  @override
  void initState() {
    super.initState();
    Provider.of<StateUser>(context, listen: false).initOpenJob();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return ApScaffold(
      title: "Lowongan",
      body: FireStoreListView(
        snapshot: state.openJobs,
        itemBuilder: (BuildContext context, DocumentSnapshot document) {
          final d = JobModel.fromJson(document.data);
          return InkWell(
            onTap: () {},
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(d.name),
                        Text(d.level, style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.date_range,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(Util.formatDate(d.dateClose, 'dd-MM-yyyy'),
                              style: TextStyle(color: Colors.grey))
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
