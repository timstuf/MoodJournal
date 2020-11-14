import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/models/mood.dart';
import 'package:mood_journal/models/mood_number.dart';
import 'package:mood_journal/ui/pages/today_mood_page.dart';
import 'package:mood_journal/ui/views/mood_picture.dart';

class MoodTile extends StatelessWidget {
  final Mood _mood;
  final List<MoodNumber> _moodNumbers;

  const MoodTile({
    Key key,
    @required Mood mood,
    @required List<MoodNumber> moodNumbers,
  })  : _mood = mood,
        _moodNumbers = moodNumbers,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).primaryColorLight,
      splashColor: findPressedNumber().color,
      onTap: () {
        _mood.moodNumber = findPressedNumber();
        Navigator.of(context).push(
          CupertinoPageRoute(builder: (_) => TodayMoodPage(mood: _mood)),
        );
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 22.0,
              child: Hero(
                tag: _mood.uniqueTag,
                child: MoodPicture(
                  assetPath: _mood.assetPath,
                ),
              ),
            ),
            SizedBox(width: 22.0),
            Expanded(
              child: Text(
                _mood.name,
                style: GoogleFonts.raleway(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }

  MoodNumber findPressedNumber()
  {
   return  _moodNumbers.firstWhere((element) => element.isPressed);
  }
}
