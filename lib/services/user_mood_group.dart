import 'package:collection/collection.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';

class UserMoodGroup {
  static Map<DateTime, List<UserMoodModel>> groupByDay(
      List<UserMoodModel> userMoods) {
    return groupBy(
        userMoods,
        (obj) =>
            DateTime(obj.dateTime.year, obj.dateTime.month, obj.dateTime.day));
  }

  static Map<DateTime, List<UserMoodModel>> getMoodsOnDay(
      Map<DateTime, List<UserMoodModel>> moodMap, DateTime day) {
    DateTime selectedDay = DateTime(day.year, day.month, day.day);
    return {selectedDay: moodMap[selectedDay]};
  }
}
