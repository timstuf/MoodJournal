import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/mocks/mood_mock.dart';
import 'package:mood_journal/models/mood_number.dart';
import 'package:mood_journal/ui/pages/today_mood_page.dart';

class MoodTile extends StatelessWidget {
  final Mood _mood;

  const MoodTile({
    Key key,
    @required Mood mood,
  })  : _mood = mood == null ? MoodMock.defaultMood : mood,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 40,
        child: MaterialButton(
      onPressed: () {},
      color: _mood.color,
      child: Text(
        _mood.name,
        style: new TextStyle(
          fontSize: 20.0,
          color:Colors.black,
        ),
      ),
      padding: EdgeInsets.all(5),
      shape: CircleBorder(),
    ),
    );
  }
}
