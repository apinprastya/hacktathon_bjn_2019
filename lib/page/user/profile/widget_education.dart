import 'package:flutter/material.dart';
import 'package:merdhamel/provider/state_user.dart';
import 'package:merdhamel/widget/empty.dart';
import 'package:provider/provider.dart';

class WidgetEducation extends StatefulWidget {
  @override
  _WidgetEducationState createState() => _WidgetEducationState();
}

class _WidgetEducationState extends State<WidgetEducation> {
  @override
  Widget build(BuildContext context) {
    final state = Provider.of<StateUser>(context);
    return Padding(
      padding: EdgeInsets.all(0.0),
      child: state.userProfile.educations.isEmpty
          ? WidgetEmpty()
          : ListView.separated(
              separatorBuilder: (c, i) => Divider(
                height: 0.0,
              ),
              itemCount: state.userProfile.educations.length,
              itemBuilder: (c, i) {
                final d = state.userProfile.educations[i];
                return InkWell(
                  onTap: () {
                    /*state.selectCurrentEducation(d);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageAddEducation()));*/
                  },
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          d.name,
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(d.level,
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            Text('${d.year}',
                                style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
