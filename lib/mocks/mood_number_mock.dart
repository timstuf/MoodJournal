import 'package:flutter/material.dart';
import 'package:mood_journal/models/mood_number.dart';

class MoodNumberMock {
  MoodNumberMock._();

  static MoodNumber defaultMood = MoodNumber(
    name: "Unknown",
    color: Color(0xFF1446A0),
  );

  static List<MoodNumber> moods = [
    MoodNumber(
      name: "1",
      color:Color(0xFF1446A0),
    ),
    MoodNumber(
      name: "2",
      color: Color(0xFF90C2E7),

    ),
    MoodNumber(
      name: "3",
      color: Color(0xFFF5D547),

    ),
    MoodNumber(
      name: "4",
      color: Color(0xFFF46036),

    ),
    MoodNumber(
      name: "5",
      color: Color(0xFFA31621),

    ),
  ];
}