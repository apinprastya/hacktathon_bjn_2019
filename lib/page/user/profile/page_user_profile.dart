import 'package:flutter/material.dart';
import 'package:merdhamel/page/user/profile/page_add_edication.dart';
import 'package:merdhamel/page/user/profile/widget_education.dart';
import 'package:merdhamel/page/user/profile/widget_info.dart';
import 'package:merdhamel/page/user/profile/widget_pelatihan.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/widget/scaffold.dart';
import 'package:provider/provider.dart';

class PageUserProfile extends StatefulWidget {
  @override
  _PageUserProfileState createState() => _PageUserProfileState();
}

class _PageUserProfileState extends State<PageUserProfile> {
  @override
  void initState() {
    super.initState();
    Provider.of<StateUser>(context, listen: false).loadUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return DefaultTabController(
      length: 4,
      child: ApScaffold(
        title: "Profil saya",
        appBar: state.userProfile == null
            ? null
            : AppBar(
                title: Text("Profil saya"),
                bottom: TabBar(
                  tabs: <Widget>[
                    Tab(
                      child: Text("Info"),
                    ),
                    Tab(
                      child: Text("Riwayat Sekolah"),
                    ),
                    Tab(
                      child: Text("Riwayat Pelatihan"),
                    ),
                    Tab(
                      child: Text("Riwayat Pekerjaan"),
                    ),
                  ],
                ),
              ),
        body: state.userProfile == null
            ? Center(child: CircularProgressIndicator())
            : TabBarView(
                children: <Widget>[
                  WidgetInfo(),
                  WidgetEducation(),
                  WidgetPelatihanList(),
                  Text('pekerjaan'),
                ],
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (c) => PageAddEducation()));
          },
        ),
      ),
    );
  }
}
