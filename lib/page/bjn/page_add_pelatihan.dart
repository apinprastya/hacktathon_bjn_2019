import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:merdhamel/model/pelatihan.dart';
import 'package:merdhamel/page/bjn/page_select_master.dart';
import 'package:merdhamel/provider/state_bjn.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageAddPelatihan extends StatefulWidget {
  @override
  _PageAddPelatihanState createState() => _PageAddPelatihanState();
}

class _PageAddPelatihanState extends State<PageAddPelatihan> {
  final _formKey = GlobalKey<FormBuilderState>();
  PelatihanMasterModel master;
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateBjn>(context);
    return ApScaffold(
      title: "Tambah pelatihan",
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () async {
                    final res = await Navigator.push(context,
                        MaterialPageRoute(builder: (c) => PageSelectMaster()));
                    if (res != null) {
                      setState(() {
                        master = res;
                      });
                    }
                  },
                  child: InputDecorator(
                    decoration: InputDecoration(
                      labelText: "Pilih master",
                      hintText: "Pilih master pelatihan",
                      contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      //border: InputBorder.none,
                    ),
                    child: Text(master == null
                        ? 'Pilih master pelatihan'
                        : master.name),
                  ),
                ),
                FormBuilderDateTimePicker(
                  inputType: InputType.date,
                  attribute: "date",
                  format: DateFormat("dd-MM-yyyy"),
                  decoration: InputDecoration(
                      hintText: "Tanggal acara", labelText: "Tanggal acara"),
                  validators: [
                    FormBuilderValidators.required(errorText: "Wajib diisi")
                  ],
                  //initialValue: state.userProfile.birthDate,
                ),
                FormBuilderDateTimePicker(
                  inputType: InputType.date,
                  attribute: "date_open",
                  format: DateFormat("dd-MM-yyyy"),
                  decoration: InputDecoration(
                      hintText: "Tanggal pendaftaran dibuka",
                      labelText: "Tanggal pendaftaran dibuka"),
                  validators: [
                    FormBuilderValidators.required(errorText: "Wajib diisi")
                  ],
                  //initialValue: state.userProfile.birthDate,
                ),
                FormBuilderDateTimePicker(
                  inputType: InputType.date,
                  attribute: "date_close",
                  format: DateFormat("dd-MM-yyyy"),
                  decoration: InputDecoration(
                      hintText: "Tanggal pendaftaran ditutup",
                      labelText: "Tanggal pendaftaran ditutup"),
                  validators: [
                    FormBuilderValidators.required(errorText: "Wajib diisi")
                  ],
                  //initialValue: state.userProfile.birthDate,
                ),
                FormBuilderTextField(
                  attribute: "max_participant",
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Maksimum peserta",
                      hintText: "Maksimum peserta"),
                  validators: [
                    FormBuilderValidators.min(1),
                  ],
                ),
                FormBuilderTextField(
                  attribute: "place",
                  decoration: InputDecoration(
                      labelText: "Tempat acara", hintText: "Tempat acara"),
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
                      if (master == null) {
                        Toast.show("Master kosong", context,
                            gravity: Toast.BOTTOM);
                        return;
                      }
                      state.pelatihan = PelatihanModel.fromJson(j);
                      state.pelatihan =
                          state.pelatihan.copyWith(master: master);
                      await state.savePelatihan();
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
