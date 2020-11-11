import 'package:mood_journal/models/mood.dart';

class MoodMock {
  MoodMock._();

  static const Mood defaultMoood = Mood(
    name: "Unknown",
    imageAssetPath: "",
  );

  static const List<Mood> moods = [
    Mood(
      name: "Very Bad",
      imageAssetPath:"",
    ),
    Mood(
      name: "Bad",
      imageAssetPath: "",

    ),
    Mood(
      name: "Neutral",
      imageAssetPath: "",

    ),
    Mood(
      name: "Good",
      imageAssetPath: "",

    ),
    Mood(
      name: "Very Good",
      imageAssetPath: "",

    ),
  ];
}