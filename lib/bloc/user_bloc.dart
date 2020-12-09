import 'package:flutter/cupertino.dart';
import 'package:mood_journal/api/api_client.dart';
import 'package:mood_journal/api/model/user_model.dart';
import 'package:mood_journal/bloc/standard_bloc.dart';

class UserPageBloc extends StandardPageBloc<UserModel> {
  UserPageBloc({@required ApiClient apiClient}) : super(apiClient: apiClient);

  void registerUser(UserModel userModel) async {
    makeCallForController(
      baseController,
      () => apiClient.registerUser(userModel),
    );
  }

  void isUser(UserModel userModel) async {
    makeCallForController(
      baseController,
      () => apiClient.isUser(userModel),
    );
  }
}
