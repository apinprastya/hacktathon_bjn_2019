import 'package:flutter/material.dart';
import 'package:merdhamel/page/page_splash.dart';
import 'package:merdhamel/pref.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await Pref.init();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          builder: (c) => StateUser(),
        ),
      ],
      child: MaterialApp(
        title: 'Merdhamel',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: PageSplash(),
      ),
    );
  }
}
