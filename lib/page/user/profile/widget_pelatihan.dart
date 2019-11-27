import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/model/user.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/util.dart';
import 'package:merdhamel/widget/firestore_listview.dart';
import 'package:provider/provider.dart';

class WidgetPelatihanList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return FireStoreListView(
      snapshot: state.myPelatihan,
      itemBuilder: (BuildContext context, DocumentSnapshot document) {
        final d = PelatihanModel.fromDocument(document);
        final s =
            d.scores.firstWhere((v) => v.email == UserModel.instance.email);
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
                      Text(d.master.name,
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.label,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(s.score, style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(d.master.level, style: TextStyle(color: Colors.grey)),
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
                        Text(Util.formatDate(d.date, 'dd-MM-yyyy'),
                            style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
