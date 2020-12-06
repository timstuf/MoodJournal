import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/models/mood_number.dart';
import 'package:mood_journal/ui/pages/mood_description_page.dart';
import 'file:///C:/Users/agris/AndroidStudioProjects/mood_journal/lib/ui/views/itemview/mood_picture.dart';

class MoodTile extends StatelessWidget {
  final MoodModel _mood;
  final DateTime _date;
  final List<MoodNumber> _moodNumbers;
  final int _userId;

  const MoodTile({
    Key key,
    @required MoodModel mood,
    @required DateTime date,
    @required List<MoodNumber> moodNumbers,
    @required int userId,
  })  : _mood = mood,
        _date = date,
        _moodNumbers = moodNumbers,
        _userId = userId,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Theme.of(context).primaryColorLight,
      splashColor: findPressedNumber().color,
      onTap: () {
        _mood.moodNumber = findPressedNumber();
        Navigator.of(context).push(
          CupertinoPageRoute(
              builder: (_) => MoodDescriptionPage(
                    mood: _mood,
                    dateTime:_date,
                userId: _userId,
                  )),
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

  MoodNumber findPressedNumber() {
    return _moodNumbers.firstWhere((element) => element.isPressed);
  }
}
