import 'package:mood_journal/models/mood.dart';
import 'package:mood_journal/resources/app_image_assets.dart';

class MoodMock {
  MoodMock._();

  static Mood defaultMood = Mood(
    name: "Unknown",
    assetPath: "Color(0xFF1446A0)",
  );

  static List<Mood> moods = [
    Mood(
      name: "angry",
      assetPath: AppImageAssets.angry,
    ),
    Mood(
      name: "happy",
      assetPath: AppImageAssets.happy,
    ),
    Mood(
      name: "super",
      assetPath: AppImageAssets.superMood,
    )
  ];
}
