import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/models/mood.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/views/check_button.dart';
import 'package:mood_journal/ui/views/mood_picture.dart';

import 'mood_history_page.dart';

class TodayMoodPage extends StatelessWidget {
  final Mood mood;

  const TodayMoodPage({
    Key key,
    @required this.mood,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: Text(
          Strings.todayMoodPageTitle,
          style: GoogleFonts.raleway(color: Colors.black),
        ),
        backgroundColor: mood.moodNumber.color,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: _buildPageContent(context),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildPageContent(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(height: 40.0),
        _buildContactPicture(),
        SizedBox(height: 3.0),
        _buildFullName(),
        SizedBox(height: 30.0),
        _buildTextArea(context),
        SizedBox(height: 60.0),
        _buildNextButton(context)
      ],
    ));
  }

  Widget _buildContactPicture() {
    return Center(
      child: Hero(
        tag: mood.uniqueTag,
        child: MoodPicture(
          assetPath: mood.assetPath,
          size: 50.0,
        ),
      ),
    );
  }

  Widget _buildFullName() {
    return Text(
      mood.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 24.0,
      ),
    );
  }

  Widget _buildTextArea(BuildContext context) {
    return SizedBox(
        width: 300.0, child: ViewWidget(moodColor: mood.moodNumber.color));
  }

  Widget _buildNextButton(BuildContext context) {
    return MaterialButton(
      onPressed: () => {
        Navigator.of(context)
            .push(CupertinoPageRoute(builder: (_) => MoodHistoryPage()))
      },
      color: mood.moodNumber.color,
      child: Text(
        "Next",
        style: new TextStyle(
          fontSize: 20.0,
          color: Colors.black,
        ),
      ),
      padding: EdgeInsets.all(5),
    );
  }
}
