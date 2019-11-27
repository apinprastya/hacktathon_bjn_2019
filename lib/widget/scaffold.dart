import 'package:flutter/material.dart';
import 'package:merdhamel/widget/drawer.dart';

class ApScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final List<Widget> actions;
  final Widget floatingActionButton;
  final PreferredSizeWidget appBar;

  ApScaffold(
      {@required this.body,
      @required this.title,
      this.actions,
      this.appBar,
      this.floatingActionButton});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this.body,
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
