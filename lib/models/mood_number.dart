import 'package:flutter/material.dart';

class MoodNumber {
  final String name;
  final Color color;
  bool isPressed;

  MoodNumber({
    @required this.name,
    @required this.color,
    this.isPressed = false,
  });

  String get uniqueTag => "$name$hashCode";

  void pressButton(List<MoodNumber> moodNumbers) {
   for (var o in moodNumbers) {
      o.isPressed=false;
    }
    this.isPressed = !this.isPressed;
  }
}
