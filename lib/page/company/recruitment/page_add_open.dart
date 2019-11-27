import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:merdhamel/model/jobs.dart';
import 'package:merdhamel/provider/state_company.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class PageAddOpen extends StatefulWidget {
  @override
  _PageAddOpenState createState() => _PageAddOpenState();
}

class _PageAddOpenState extends State<PageAddOpen> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateCompany>(context);
    return ApScaffold(
      title: "Tambah lowongan",
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FormBuilderTextField(
                  attribute: "name",
                  decoration: InputDecoration(
                      labelText: "Nama lowongan", hintText: "Nama lowongan"),
                  validators: [
                    FormBuilderValidators.required(),
                  ],
                  maxLines: null,
                ),
                FormBuilderDateTimePicker(
                  inputType: InputType.date,
                  attribute: "date_close",
                  format: DateFormat("dd-MM-yyyy"),
                  decoration: InputDecoration(
                      hintText: "Tanggal lowongan ditutup",
                      labelText: "Tanggal lowongan ditutup"),
                  validators: [
                    FormBuilderValidators.required(errorText: "Wajib diisi")
                  ],
                  //initialValue: state.userProfile.birthDate,
                ),
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
                      state.job = JobModel.fromJson(j);
                      await state.saveJob();
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
