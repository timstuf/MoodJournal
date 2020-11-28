import 'package:flutter/cupertino.dart';
import 'package:mood_journal/api/api_client.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/bloc/standard_bloc.dart';

class MoodPageBloc extends StandardPageBloc<MoodModel> {
  MoodPageBloc({
    @required ApiClient apiClient,
  }) : super(apiClient: apiClient);

  void getAllMoods() async {
    makeCallForController(
      baseController,
      () => apiClient.getMoods(),
    );
  }
}
