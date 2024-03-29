import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/user.dart';
import 'package:merdhamel/model/usersession.dart';
import 'package:merdhamel/page/bjn/page_bjn.dart';
import 'package:merdhamel/page/company/page_company.dart';
import 'package:merdhamel/page/page_login.dart';
import 'package:merdhamel/pref.dart';
import 'package:merdhamel/page/user/pelatihan/page_pelatihan.dart';

class PageSplash extends StatefulWidget {
  @override
  _PageSplashState createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  @override
  void initState() {
    super.initState();
    checkUser();
  }

  checkUser() async {
    await Future.delayed(const Duration(seconds: 3));
    await UserSession.instance.init();
    final user = UserSession.instance.user;
    final uModel = Pref.pref.getString(Pref.USER);
    if (user != null && uModel != null) {
      final u = UserModel.fromJson(json.decode(uModel));
      final type = u.type;
      UserModel.instance = u;
      if (type == 'bjn')
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => PageBjn()));
      if (type == 'user')
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => PagePelatihan()));
      if (type == 'company')
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (c) => PageCompany()));
    } else {
      Navigator.pushReplacement(
        context,
        new MaterialPageRoute(builder: (c) => PageLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Image.asset("images/logo.png"),
        ),
      ),
    );
  }
}
