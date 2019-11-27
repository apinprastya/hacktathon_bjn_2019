import 'package:flutter/material.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:provider/provider.dart';

class WidgetInfo extends StatefulWidget {
  @override
  _WidgetInfoState createState() => _WidgetInfoState();
}

class _WidgetInfoState extends State<WidgetInfo> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Nama lengkap", labelText: "Nama lengkap"),
                validator: (v) => v.length > 0 ? null : 'Wajib diisi',
                onSaved: (v) =>
                    state.userProfile = state.userProfile.copyWith(name: v),
              ),
              TextFormField(
                decoration:
                    InputDecoration(hintText: "Alamat", labelText: "Alamat"),
                validator: (v) => v.length > 0 ? null : 'Wajib diisi',
                onSaved: (v) =>
                    state.userProfile = state.userProfile.copyWith(address: v),
              ),
              TextFormField(
                decoration:
                    InputDecoration(hintText: "Desa", labelText: "Desa"),
                validator: (v) => v.length > 0 ? null : 'Wajib diisi',
                onSaved: (v) =>
                    state.userProfile = state.userProfile.copyWith(desa: v),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Kecamatan", labelText: "Kecamatan"),
                validator: (v) => v.length > 0 ? null : 'Wajib diisi',
                onSaved: (v) => state.userProfile =
                    state.userProfile.copyWith(kecamatan: v),
              ),
              TextFormField(
                decoration: InputDecoration(
                    hintText: "Kabupaten", labelText: "Kabupaten"),
                validator: (v) => v.length > 0 ? null : 'Wajib diisi',
                onSaved: (v) => state.userProfile =
                    state.userProfile.copyWith(kabupaten: v),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                width: double.infinity,
                child: RaisedButton(
                  child: Text("Simpan"),
                  onPressed: () async {
                    await state.save();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
