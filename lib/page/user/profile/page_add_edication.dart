import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:merdhamel/model/user_profile.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageAddEducation extends StatefulWidget {
  @override
  _PageAddEducationState createState() => _PageAddEducationState();
}

class _PageAddEducationState extends State<PageAddEducation> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return ApScaffold(
      title:
          state.userEducation == null ? "Tambah Pendidikan" : "Edit pendidikan",
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: FormBuilder(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  FormBuilderDropdown(
                    attribute: "level",
                    decoration: InputDecoration(labelText: "Level pendidikan"),
                    hint: Text('Level pendidikan'),
                    validators: [FormBuilderValidators.required()],
                    items: [
                      'SD',
                      'SMP',
                      'SMA',
                      'D1',
                      'D2',
                      'D3',
                      'D4',
                      'S1',
                      'S2',
                      'S3'
                    ]
                        .map((v) =>
                            DropdownMenuItem(value: v, child: Text("$v")))
                        .toList(),
                    initialValue: state.userEducation?.level,
                  ),
                  FormBuilderTextField(
                    attribute: "name",
                    decoration: InputDecoration(
                        hintText: "Nama sekolah / universitas",
                        labelText: "Nama sekolah / universitas"),
                    validators: [
                      FormBuilderValidators.required(errorText: "Wajib diisi")
                    ],
                    initialValue: state.userEducation?.name,
                  ),
                  FormBuilderTextField(
                    attribute: "year",
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        hintText: "Tahun lulus", labelText: "Tahun lulus"),
                    validators: [
                      FormBuilderValidators.min(1980),
                      FormBuilderValidators.max(2019),
                    ],
                    initialValue: state.userEducation == null
                        ? null
                        : '${state.userEducation.year}',
                  ),
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
                              "Simpan",
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: () async {
                        if (!_formKey.currentState.saveAndValidate()) return;
                        final j = _formKey.currentState.value;
                        state.userProfile = state.userProfile.copyWith(
                            educations: (List.from(state.userProfile.educations)
                              ..add(UserEducation.fromJson(j))));
                        await state.save();
                        Toast.show("Berhasil disimpan", context,
                            gravity: Toast.BOTTOM);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
