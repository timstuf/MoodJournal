import 'package:flutter/material.dart';
import 'package:mood_journal/resources/utils.dart';

class MoodNumber {
  final int number;
  Color color;
  bool isPressed;

  MoodNumber({
    @required this.number,
    this.isPressed = false,
  }) {
    _init();
  }

  _init() {
    color = Utils.getMoodColorByNumber(number);
  }

  String get uniqueTag => "$number$hashCode";

  void pressButton(List<MoodNumber> moodNumbers) {
    for (var o in moodNumbers) {
      o.isPressed = false;
    }
    this.isPressed = !this.isPressed;
  }

  static List<MoodNumber> getAllMoods() {
    return List.generate(5, (index) {
      return MoodNumber(number: index + 1);
    });
  }
}
