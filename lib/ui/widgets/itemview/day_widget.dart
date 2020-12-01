import 'package:flutter/material.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/services/date_formatter.dart';
import 'package:mood_journal/ui/views/mood_picture.dart';

import 'my_text.dart';

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
          child: MyText(text:DateFormatter.dateFormatter(_dateTime)),
        ),

        Container(
            child: GridView.count(
          shrinkWrap: true,
          primary: false,
          childAspectRatio: 50.0 / 50.0,
          padding: const EdgeInsets.all(20),
          scrollDirection: Axis.vertical,
          crossAxisCount: 4,
          children: _buildUserMoods(),
        ))
      ],
    );
  }

  List<Widget> _buildUserMoods() {
    List<Widget> listButtons = List.generate(_userMoods.length, (i) {
      UserMoodModel mood = _userMoods[i];
      return Padding(
          padding: EdgeInsets.all(3),
          child: SizedBox(
            width: 72,
            child: Column(
              children: [
                MyText(text: DateFormatter.getTime(mood.dateTime)),
                MoodPicture(assetPath: mood.moodModel.assetPath)
              ],
            ),
          ));
    });
    return listButtons;
  }
}
