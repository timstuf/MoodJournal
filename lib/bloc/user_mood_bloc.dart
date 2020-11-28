import 'package:flutter/cupertino.dart';
import 'package:mood_journal/api/api_client.dart';
import 'package:mood_journal/api/model/user_mood_model.dart';
import 'package:mood_journal/bloc/standard_bloc.dart';

class UserMoodPageBloc extends StandardPageBloc<UserMoodModel> {
  UserMoodPageBloc({
    @required ApiClient apiClient
  }) : super(apiClient: apiClient);

  void getAllUserMoods(int id) async {
    makeCallForController(
      baseController,
      () => apiClient.getUserMoods(id),
    );
  }

  void saveUserMood(UserMoodModel userMoodModel) async {
    makeCallForController(
      baseController,
          () => apiClient.saveUserMood(userMoodModel),
    );
  }
}
