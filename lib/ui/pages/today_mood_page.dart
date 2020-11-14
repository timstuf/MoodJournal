import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/models/mood.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/views/mood_picture.dart';
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
      body: Center(
        child: _buildPageContent(),
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

  Widget _buildPageContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildContactPicture(),
        SizedBox(height: 16.0),
        _buildFullName(),
      ],
    );
  }

  Widget _buildContactPicture() {
    return Center(
      child: Hero(
        tag: mood.uniqueTag,
        child: MoodPicture(
          assetPath: mood.assetPath,
          size: 200.0,
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
}