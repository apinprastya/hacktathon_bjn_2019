import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:merdhamel/page/page_login.dart';
import 'package:merdhamel/page/user/page_user.dart';
import 'package:merdhamel/page/user/profile/page_user_profile.dart';

class ApDrawer extends StatelessWidget {
  _user(BuildContext context) {
    return [
      ListTile(
        leading: Icon(Icons.home),
        title: Text('Beranda'),
        onTap: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (c) => PageUser()));
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

  @override
  Widget build(BuildContext context) {
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
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage("images/splashlogo.jpg"),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: _user(context),
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
