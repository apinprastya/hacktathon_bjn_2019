import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/page/user/pelatihan/page_detail_pelatihan.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/util.dart';
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
    Provider.of<StateUser>(context, listen: false).initPelatihan();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return ApScaffold(
      title: "Pelatihan",
      body: FireStoreListView(
        snapshot: state.pelatihanOpen,
        itemBuilder: (BuildContext context, DocumentSnapshot document) {
          final d = PelatihanModel.fromDocument(document);
          return InkWell(
            onTap: () {
              state.pelatihan = d;
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => PageDetailPelatihan()));
            },
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
                              Icons.people,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Text(
                                '${d.participants.length} / ${d.maxParticipant}',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(d.master.level,
                          style: TextStyle(color: Colors.grey)),
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
      ),
    );
  }
}
