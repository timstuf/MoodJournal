import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mood_journal/resources/strings.dart';

class MoodHistoryPage extends StatelessWidget {
  const MoodHistoryPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _buildBackButton(context),
        title: Text(
          Strings.moodHistoryPageTitle,
          style: GoogleFonts.raleway(color: Colors.black),
        ),
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
      ],
    ));
  }
}
