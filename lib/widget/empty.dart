import 'package:flutter/material.dart';

class WidgetEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Icon(
          Icons.dns,
          size: 80.0,
          color: Colors.grey,
        ),
        SizedBox(
          height: 8.0,
        ),
        Text(
          'Tidak ada Data',
          style: TextStyle(color: Colors.grey),
        ),
      ]),
    );
  }
}
