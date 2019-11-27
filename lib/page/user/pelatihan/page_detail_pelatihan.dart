import 'package:flutter/material.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/util.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageDetailPelatihan extends StatefulWidget {
  @override
  _PageDetailPelatihanState createState() => _PageDetailPelatihanState();
}

class _PageDetailPelatihanState extends State<PageDetailPelatihan> {
  _detail(BuildContext context, String title, String value) {
    return InputDecorator(
      child: Text(value),
      decoration: InputDecoration(labelText: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
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
                        "Daftar pelatihan ini",
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () async {
                  try {
                    await state.joinPelatihan();
                    Toast.show("Berhasil ikut pelatihan", context,
                        gravity: Toast.BOTTOM);
                    Navigator.pop(context);
                  } catch (e) {
                    Toast.show(e.toString(), context, gravity: Toast.BOTTOM);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
