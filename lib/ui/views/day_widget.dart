import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/services/date_formatter.dart';
import 'package:mood_journal/ui/pages/view_mood_description_page.dart';
import 'file:///C:/Users/agris/AndroidStudioProjects/mood_journal/lib/ui/views/itemview/mood_picture.dart';

import 'itemview/my_text.dart';

class DayWidget extends StatelessWidget {
  final DateTime _dateTime;
  final List<UserMoodModel> _userMoods;

  const DayWidget({
    Key key,
    @required DateTime dateTime,
    @required List<UserMoodModel> userMoods,
  })  : _dateTime = dateTime,
        _userMoods = userMoods,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.0),
        SizedBox(
          height: 20.0,
          child: MyText(
            text: DateFormatter.dateFormatter(_dateTime),
            size: 20,
          ),
        ),
        Container(
            child: GridView.count(
          shrinkWrap: true,
          primary: false,
          childAspectRatio: 50.0 / 50.0,
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          crossAxisCount: 4,
          children: _buildUserMoods(context),
        ))
      ],
    );
  }

  List<Widget> _buildUserMoods(BuildContext context) {
    List<Widget> listButtons = List.generate(_userMoods.length, (i) {
      UserMoodModel mood = _userMoods[i];
      return InkWell(
          child: Padding(
              padding: EdgeInsets.all(3),
              child: SizedBox(
                width: 72,
                child: Column(
                  children: [
                    MyText(
                      text: DateFormatter.getTime(mood.dateTime),
                      size: 14,
                    ),
                    MoodPicture(assetPath: mood.moodModel.assetPath)
                  ],
                ),
              )),
          onTap: () {
            Navigator.of(context).push(
              CupertinoPageRoute(
                  builder: (_) => ViewMoodDescriptionPage(
                        mood: mood,
                      )),
            );
          });
    });
    return listButtons;
  }
}
