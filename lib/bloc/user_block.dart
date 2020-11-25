import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:mood_journal/api/api_client.dart';
import 'package:mood_journal/api/api_error.dart';
import 'package:mood_journal/api/model/user_model.dart';
import 'package:mood_journal/bloc/state.dart';


class UserPageBloc extends BlocBase {
  final ApiClient apiClient;

  UserPageBloc(this.apiClient);

  final _userController = StreamController<AppState<List<UserModel>>>()
    ..add(InitialState());

  Stream<AppState<List<UserModel>>> get userStream => _userController.stream;

  @override
  void dispose() {
    _userController.close();
    super.dispose();
  }

  void getAllUsers() async {
    _makeCallForController(
      _userController,
          () => apiClient.getUsers(),
    );
  }

  void _makeCallForController<T>(
      StreamController<AppState<T>> controller,
      Future<T> Function() call,
      ) async {
    controller.add(LoadingState());
    try {
      T data = await call();
      controller.add(SuccessState(data));
    } on ApiError catch (ex) {
      controller.add(ErrorState(ex.message));
    }
  }
}