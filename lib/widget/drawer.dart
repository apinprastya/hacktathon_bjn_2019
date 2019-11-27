import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/model/user.dart';
import 'package:merdhamel/page/bjn/page_bjn.dart';
import 'package:merdhamel/page/bjn/page_palatihan.dart';
import 'package:merdhamel/page/company/page_company.dart';
import 'package:merdhamel/page/company/recruitment/page_open.dart';
import 'package:merdhamel/page/page_login.dart';
import 'package:merdhamel/page/user/job/page_user_job.dart';
import 'package:merdhamel/page/user/pelatihan/page_pelatihan.dart' as pp;
import 'package:merdhamel/page/user/profile/page_user_profile.dart';

class ApDrawer extends StatelessWidget {
  _user(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.work),
        title: Text('Pelatihan'),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => pp.PagePelatihan()));
        },
      ),
      ListTile(
        leading: Icon(Icons.group_work),
        title: Text('Lowongan'),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => PageUserJob()));
        },
      ),
      ListTile(
        leading: Icon(Icons.person),
        title: Text('Profil Saya'),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => PageUserProfile()));
        },
      ),
    ];
  }

  _bjn(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.view_day),
        title: Text('Master pelatihan'),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => PageBjn()));
        },
      ),
      ListTile(
        leading: Icon(Icons.next_week),
        title: Text('Pelatihan'),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => PagePelatihan()));
        },
      ),
    ];
  }

  _company(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.info),
        title: Text('Info'),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => PageCompany()));
        },
      ),
      ListTile(
        leading: Icon(Icons.work),
        title: Text('Lowongan'),
        onTap: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (c) => PageOpenRecruitment()));
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final u = UserModel.instance;
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200.0,
            color: Theme.of(context).primaryColor,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 48,
                ),
                Container(
                  width: 120.0,
                  height: 120.0,
                  decoration: new BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/logo.png"),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(UserModel.instance.email,
                    style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: u.type == 'user'
                  ? _user(context)
                  : u.type == "bjn" ? _bjn(context) : _company(context),
            ),
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (c) => PageLogin()));
            },
          ),
        ],
      ),
    );
  }
}
