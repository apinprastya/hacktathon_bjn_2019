import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:intl/intl.dart';

class WidgetInfo extends StatefulWidget {
  @override
  _WidgetInfoState createState() => _WidgetInfoState();
}

class _WidgetInfoState extends State<WidgetInfo> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: FormBuilder(
          key: _formKey,
          initialValue: state.userProfile.toJson(),
          child: Column(
            children: <Widget>[
              FormBuilderTextField(
                attribute: "name",
                decoration: InputDecoration(
                    hintText: "Nama lengkap", labelText: "Nama lengkap"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.name,
              ),
              FormBuilderRadio(
                attribute: "gender",
                options: ["Laki-laki", "Perempuan"]
                    .map(
                      (v) => FormBuilderFieldOption(
                        value: v,
                        label: v,
                      ),
                    )
                    .toList(),
                decoration: InputDecoration(
                    hintText: "Jenis kelamin", labelText: "Jenis kelamin"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.gender,
              ),
              FormBuilderTextField(
                attribute: "birth_place",
                decoration: InputDecoration(
                    hintText: "Tempat lahir", labelText: "Tempat lahir"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.birthPlace,
              ),
              FormBuilderDateTimePicker(
                inputType: InputType.date,
                attribute: "birth_date",
                format: DateFormat("dd-MM-yyyy"),
                decoration: InputDecoration(
                    hintText: "Tanggal lahir", labelText: "Tanggal lahir"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.birthDate,
              ),
              FormBuilderDropdown(
                attribute: "marital_status",
                decoration: InputDecoration(labelText: "Status perkawinan"),
                hint: Text('Pilih status perkawinan'),
                validators: [FormBuilderValidators.required()],
                items: ['Belum Kawin', 'Kawin', 'Cerai Hidup', 'Cerai Mati']
                    .map((v) => DropdownMenuItem(value: v, child: Text("$v")))
                    .toList(),
                initialValue: state.userProfile.maritalStatus,
              ),
              FormBuilderTextField(
                attribute: "address",
                decoration:
                    InputDecoration(hintText: "Alamat", labelText: "Alamat"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                maxLines: null,
                initialValue: state.userProfile.address,
              ),
              FormBuilderTextField(
                attribute: "desa",
                decoration:
                    InputDecoration(hintText: "Desa", labelText: "Desa"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.desa,
              ),
              FormBuilderTextField(
                attribute: "kecamatan",
                decoration: InputDecoration(
                    hintText: "Kecamatan", labelText: "Kecamatan"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.kecamatan,
              ),
              FormBuilderTextField(
                attribute: "kabupaten",
                decoration: InputDecoration(
                    hintText: "Kabupaten", labelText: "Kabupaten"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.kabupaten,
              ),
              FormBuilderTextField(
                attribute: "provinsi",
                decoration: InputDecoration(
                    hintText: "Provinsi", labelText: "Provinsi"),
                validators: [
                  FormBuilderValidators.required(errorText: "Wajib diisi")
                ],
                initialValue: state.userProfile.provinsi,
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
                      name: j['name'],
                      birthPlace: j['birth_place'],
                      birthDate: j['birth_date'],
                      address: j['address'],
                      desa: j['desa'],
                      gender: j['gender'],
                      kabupaten: j['kabupaten'],
                      kecamatan: j['kecamatan'],
                      maritalStatus: j['marital_status'],
                      provinsi: j['provinsi'],
                    );
                    await state.save();
                    Toast.show("Berhasil disimpan", context,
                        gravity: Toast.BOTTOM);
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
