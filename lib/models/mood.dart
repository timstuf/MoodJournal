import 'package:flutter/cupertino.dart';
import 'package:mood_journal/models/mood_number.dart';

class Mood {
  final String name;
  MoodNumber moodNumber;
  final String assetPath;
  bool isPressed;

  Mood({
    @required this.name,
    @required this.assetPath,
    @required this.moodNumber,
    this.isPressed = false,
  });

  String get uniqueTag => "$name$hashCode";
}