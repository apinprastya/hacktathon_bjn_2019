import 'package:flutter/material.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageDetailJob extends StatefulWidget {
  @override
  _PageDetailJobState createState() => _PageDetailJobState();
}

class _PageDetailJobState extends State<PageDetailJob> {
  _detail(BuildContext context, String title, String value) {
    return InputDecorator(
      child: Text(value),
      decoration: InputDecoration(labelText: title),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    final job = state.jobModel;
    return ApScaffold(
      title: "Detail lowongan",
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: ListView(
          children: <Widget>[
            _detail(context, 'Perusahaan', job.company.name),
            _detail(context, 'Judul lowongan', job.name),
            _detail(context, 'Level', job.level),
            _detail(context, 'Deskripsi', job.description),
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
                        "Daftar lowongan ini",
                        style: TextStyle(color: Colors.white),
                      ),
                onPressed: () async {
                  try {
                    await state.register();
                    Toast.show("Berhasil mendaftar lowongan", context,
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
