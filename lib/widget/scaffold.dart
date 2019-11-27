import 'package:flutter/material.dart';
import 'package:merdhamel/widget/drawer.dart';

class ApScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget> actions;
  final Widget floatingActionButton;
  final PreferredSizeWidget appBar;
  final Key key;

  ApScaffold({
    @required this.body,
    @required this.title,
    this.key,
    this.actions,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.body,
      key: key,
      appBar: appBar == null
          ? AppBar(
              title: Text(this.title),
              actions: this.actions,
            )
          : appBar,
      floatingActionButton: floatingActionButton,
      drawer: !Navigator.canPop(context) ? ApDrawer() : null,
    );
  }
}
