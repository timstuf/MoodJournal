import 'package:flutter/material.dart';
import 'package:mood_journal/mocks/mood_mock.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/views/mood_number.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Strings.homePageTitle,
          style: GoogleFonts.raleway(color: Colors.black),
        ),
        backgroundColor: Color(0xFF97C8EB),
        centerTitle: true,
      ),
      body: Center(
          child: Column(children: <Widget>[
            Center(
          child: Padding(
            padding: EdgeInsets.only(top: 55),
            child: Text(
              "How would you rate this moment?",
              textAlign: TextAlign.center,
              style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: new ButtonBar(
            mainAxisSize: MainAxisSize.min,

            // this will take space as minimum as posible(to center)
            children:
                MoodMock.moods.map((mood) => MoodTile(mood: mood)).toList(),
          ),
        )
      ])),
    );
  }
}
