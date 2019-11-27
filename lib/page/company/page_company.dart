import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:merdhamel/model/company.dart';
import 'package:merdhamel/provider/state_company.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PageCompany extends StatefulWidget {
  @override
  _PageCompanyState createState() => _PageCompanyState();
}

class _PageCompanyState extends State<PageCompany> {
  final _formKey = GlobalKey<FormBuilderState>();
  @override
  void initState() {
    super.initState();
    Provider.of<StateCompany>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateCompany>(context);
    return ApScaffold(
      title: "Company Info",
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: state.company == null
              ? Center(child: CircularProgressIndicator())
              : FormBuilder(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        FormBuilderTextField(
                          attribute: "name",
                          decoration: InputDecoration(
                              labelText: "Nama", hintText: "Nama"),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          initialValue: state.company.name,
                        ),
                        FormBuilderTextField(
                          attribute: "phone",
                          decoration: InputDecoration(
                              labelText: "Telepon", hintText: "Telepon"),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          initialValue: state.company.phone,
                        ),
                        FormBuilderTextField(
                          attribute: "address",
                          decoration: InputDecoration(
                              labelText: "Alamat", hintText: "Alamat"),
                          validators: [
                            FormBuilderValidators.required(),
                          ],
                          maxLines: null,
                          initialValue: state.company.address,
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
                              if (!_formKey.currentState.saveAndValidate())
                                return;
                              final j = _formKey.currentState.value;
                              state.company = CompanyModel.fromJson(j);
                              state.save();
                              Toast.show("Berhasil disimpan", context,
                                  gravity: Toast.BOTTOM);
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
