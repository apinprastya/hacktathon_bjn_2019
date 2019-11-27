import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/provider/state_bjn.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageAddMaster extends StatefulWidget {
  @override
  _PageAddMasterState createState() => _PageAddMasterState();
}

class _PageAddMasterState extends State<PageAddMaster> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateBjn>(context);
    return ApScaffold(
      title: "Tambah master pelatihan",
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FormBuilderDropdown(
                  attribute: "level",
                  decoration: InputDecoration(labelText: "Level"),
                  // initialValue: 'Male',
                  hint: Text('Pilih level'),
                  validators: [FormBuilderValidators.required()],
                  items: ['Junior 1', 'Junior 2', 'Senior', 'Supervisor']
                      .map((v) => DropdownMenuItem(value: v, child: Text("$v")))
                      .toList(),
                ),
                FormBuilderTextField(
                  attribute: "name",
                  decoration:
                      InputDecoration(labelText: "Nama", hintText: "Nama"),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                ),
                FormBuilderTextField(
                  attribute: "description",
                  decoration: InputDecoration(
                      labelText: "Deskripsi", hintText: "Deskripsi"),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  maxLines: null,
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
                      state.pelatihanMaster = PelatihanMasterModel.fromJson(j);
                      await state.saveMaster();
                      Toast.show("Berhasil disimpan", context,
                          gravity: Toast.BOTTOM);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
