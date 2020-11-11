import 'package:flutter/material.dart';
import 'package:mood_journal/mocks/mood_mock.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/views/mood_number.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.homePageTitle),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: MoodMock.moods
            .map((mood) => MoodTile(mood: mood))
        .toList(),
        ),
      ),
    );
  }
}