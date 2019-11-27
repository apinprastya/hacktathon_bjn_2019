import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/model/user.dart';
import 'package:merdhamel/model/user_profile.dart';
import 'package:merdhamel/provider/state_bjn.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageListParticipant extends StatefulWidget {
  @override
  _PageListParticipantState createState() => _PageListParticipantState();
}

class _PageListParticipantState extends State<PageListParticipant> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateBjn>(context);
    return ApScaffold(
        //key: _scaffoldKey,
        title: "Peserta",
        body: ListView.separated(
          itemCount: state.pelatihan.participants.length,
          separatorBuilder: (c, i) => Divider(
            height: 0.0,
          ),
          itemBuilder: (c, i) {
            return ListTile(
              title: Text(state.pelatihan.participants[i]),
              onTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) =>
                        WidgetDetailUser(state.pelatihan.participants[i]));
              },
            );
          },
        ));
  }
}

class WidgetDetailUser extends StatefulWidget {
  final String email;

  WidgetDetailUser(this.email);
  @override
  _WidgetDetailUserState createState() => _WidgetDetailUserState();
}

class _WidgetDetailUserState extends State<WidgetDetailUser> {
  UserProfileModel user;
  bool saving = false;
  _detail(BuildContext context, String title, String value) {
    return InputDecorator(
      child: Text(value),
      decoration: InputDecoration(labelText: title),
    );
  }

  @override
  void initState() {
    super.initState();
    Firestore.instance.document('profiles/${widget.email}').get().then((v) {
      user = UserProfileModel.fromJson(v.data);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: 200.0,
      child: user == null
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      _detail(context, 'Nama', user.name),
                      _detail(context, 'Alamat', user.address),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50.0,
                  child: RaisedButton(
                    color: Theme.of(context).primaryColor,
                    child: saving
                        ? CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          )
                        : Text(
                            "Tandai sukses",
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: () async {
                      try {
                        final state =
                            Provider.of<StateBjn>(context, listen: false);
                        state.pelatihan = state.pelatihan.copyWith(
                          success: (List.from(state.pelatihan.success)
                            ..add(widget.email)),
                          scores: (List.from(state.pelatihan.scores)
                            ..add(PelatihanScoreModel(
                                email: widget.email, score: 'Baik'))),
                        );
                        final index = state.pelatihan.success
                            .indexWhere((v) => v == widget.email);
                        if (index >= 0) {
                          Toast.show("User sudah sukses", context,
                              gravity: Toast.BOTTOM);
                          return;
                        }
                        saving = true;
                        setState(() {});
                        final ref = Firestore.instance
                            .document('pelatihans/${state.pelatihan.id}');
                        await ref.setData(state.pelatihan.toJson(),
                            merge: true);
                        Toast.show("Berhasil menandai sukses", context,
                            gravity: Toast.BOTTOM);
                        saving = false;
                        setState(() {});
                        Navigator.pop(context);
                      } catch (e) {}
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
