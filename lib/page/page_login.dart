import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:merdhamel/model/user.dart';
import 'package:merdhamel/page/bjn/page_bjn.dart';
import 'package:merdhamel/page/company/page_company.dart';
import 'package:merdhamel/page/user/page_user.dart';
import 'package:merdhamel/pref.dart';

class PageLogin extends StatefulWidget {
  @override
  _PageLoginState createState() => _PageLoginState();
}

class _PageLoginState extends State<PageLogin> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String _email;
  String _password;
  bool _loading = false;

  _login() async {
    if (_loading) return;
    if (!_formKey.currentState.validate()) return;
    _formKey.currentState.save();
    setState(() {
      _loading = true;
    });
    try {
      final res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      final d =
          await Firestore.instance.document("users/${res.user.email}").get();
      if (d.data == null) {
        final u =
            UserModel(id: res.user.uid, email: res.user.email, type: 'user');
        await Firestore.instance
            .document("users/${res.user.email}")
            .setData(u.toJson());
        _process('user', u);
      } else {
        final type = d.data['type'];
        _process(type, UserModel.fromDoc(d));
      }
      setState(() {
        _loading = false;
      });
    } catch (e) {
      if (e is PlatformException)
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text(e.message),
        ));
      setState(() {
        _loading = false;
      });
    }
  }

  _process(String type, UserModel user) async {
    await Pref.pref.setString(Pref.USER, json.encode(user.toJson()));
    if (type == 'bjn')
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => PageBjn()));
    if (type == 'user')
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => PageUser()));
    if (type == 'company')
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (c) => PageCompany()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 300,
                    child: Image.asset("images/splashlogo.jpg"),
                  ),
                  TextFormField(
                    decoration:
                        InputDecoration(labelText: "Email", hintText: "Email"),
                    validator: (v) => v.isEmpty ? 'Tidak boleh kosong' : null,
                    onSaved: (v) => _email = v,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password", hintText: "Password"),
                    obscureText: true,
                    onSaved: (v) => _password = v,
                    validator: (v) => v.isEmpty ? 'Tidak boleh kosong' : null,
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50.0,
                    child: RaisedButton(
                      color: Colors.orange,
                      child: _loading
                          ? CircularProgressIndicator()
                          : Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                      onPressed: _login,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
