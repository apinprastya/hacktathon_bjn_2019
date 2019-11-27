import 'package:flutter/material.dart';
import 'package:merdhamel/page/bjn/page_list_participant.dart';
import 'package:merdhamel/provider/state_bjn.dart';
import 'package:merdhamel/util.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageBjnDetailPelatihan extends StatefulWidget {
  @override
  _PageBjnDetailPelatihanState createState() => _PageBjnDetailPelatihanState();
}

class _PageBjnDetailPelatihanState extends State<PageBjnDetailPelatihan> {
  _detail(BuildContext context, String title, String value) {
    return InputDecorator(
      child: Text(value),
      decoration: InputDecoration(labelText: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateBjn>(context);
    final d = state.pelatihan;
    return ApScaffold(
      title: "Detail pelatihan",
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            _detail(context, "Nama", d.master.name),
            _detail(context, "Deskripsi", d.master.description),
            _detail(context, "Level", d.master.level),
            _detail(context, "Tanggal pelaksanaan",
                Util.formatDate(d.date, "dd-MM-yyyy")),
            _detail(context, "Jumlah peserta / Kuota",
                '${d.participants.length} / ${d.maxParticipant}'),
            SizedBox(
              height: 16.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: state.saving
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text(
                        "List peserta",
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () async {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => PageListParticipant()));
                },
              ),
            ),
            /*SizedBox(
              height: 8.0,
            ),
            SizedBox(
              width: double.infinity,
              height: 50.0,
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                child: state.saving
                    ? CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      )
                    : Text(
                        "List sukses",
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () async {
                  try {} catch (e) {}
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
