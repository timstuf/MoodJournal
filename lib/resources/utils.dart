import 'package:flutter/material.dart';
import 'package:mood_journal/resources/app_image_assets.dart';
import 'package:mood_journal/resources/colors.dart';

class Utils {
  Utils._();

  static Map<String, String> moodAssets = {
    "angry": AppImageAssets.angry,
    "blah": AppImageAssets.blah,
    "content": AppImageAssets.content,
    "super": AppImageAssets.superMood,
    "happy": AppImageAssets.happy,
    "hopeful": AppImageAssets.hopeful,
    "stressed": AppImageAssets.stressed,
    "worried": AppImageAssets.worried
  };

  static Map<int, String> moodColors = {
    1: AppColors.firstMoodColor,
    2: AppColors.secondMoodColor,
    3: AppColors.thirdMoodColor,
    4: AppColors.fourthMoodColor,
    5: AppColors.fifthMoodColor,
  };

  static Color getMoodColorByNumber(int number) {
    return Color(int.parse(moodColors[number]));
  }

  static String getAssetByName(String name) {
    return moodAssets[name];
  }

  static Color getMainColor() {
    return Color(int.parse(AppColors.mainColor));
  }

  static Color getAccentColor() {
    return Color(int.parse(AppColors.accentColor));
  }

  static Color getDarkerMainColor() {
    return Color(int.parse(AppColors.darkerMainColor));
  }
}
