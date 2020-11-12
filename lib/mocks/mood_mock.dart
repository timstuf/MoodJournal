import 'package:flutter/material.dart';
import 'package:mood_journal/models/mood_number.dart';

class MoodMock {
  MoodMock._();

  static const Mood defaultMood = Mood(
    name: "Unknown",
    color: Color(0xFF1446A0),
  );

  static const List<Mood> moods = [
    Mood(
      name: "1",
      color:Color(0xFF1446A0),
    ),
    Mood(
      name: "2",
      color: Color(0xFF90C2E7),

    ),
    Mood(
      name: "3",
      color: Color(0xFFF5D547),

    ),
    Mood(
      name: "4",
      color: Color(0xFFF46036),

    ),
    Mood(
      name: "5",
      color: Color(0xFFA31621),

    ),
  ];
}