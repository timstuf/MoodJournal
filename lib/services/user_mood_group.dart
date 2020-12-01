import 'package:collection/collection.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';

class UserMoodGroup{

  static Map <DateTime, List<UserMoodModel>> groupByDay (List<UserMoodModel> userMoods){
    return  groupBy(userMoods, (obj) => DateTime(obj.dateTime.day));
  }
}