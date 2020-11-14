import 'package:flutter/material.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/pages/home_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.appName,
      theme: ThemeData(
        primaryColor: Color(0xFF97C8EB),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
