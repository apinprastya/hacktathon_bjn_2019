import 'package:flutter/material.dart';
import 'package:merdhamel/widget/scaffold.dart';

class PageUser extends StatefulWidget {
  @override
  _PageUserState createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  @override
  Widget build(BuildContext context) {
    return ApScaffold(
      title: "Beranda",
      body: Text('Beranda'),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          final file = await ImagePicker.pickImage(
            source: ImageSource.camera,
          );
          final x = await Util.uploadFile(file.path);
          print(x);
        },
      ),*/
    );
  }
}
