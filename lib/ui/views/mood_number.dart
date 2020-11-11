import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/mocks/mood_mock.dart';
import 'package:mood_journal/models/mood.dart';
import 'package:mood_journal/ui/pages/today_mood_page.dart';

class MoodTile extends StatelessWidget {
  final Mood _mood;

  const MoodTile({
    Key key,
    @required Mood mood,
  })  : _mood = mood == null ? MoodMock.defaultMoood : mood,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).primaryColorLight,
      splashColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => TodayMoodPage(mood: _mood)),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            MaterialButton(
              onPressed: () {},
              color: Colors.blue,
              textColor: Colors.white,
              child:
              Text(_mood.name),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            ),
            SizedBox(width: 22.0),
            Expanded(
              child: _buildContactShortInfo(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactShortInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _mood.name,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 4.0),
      ],
    );
  }
}