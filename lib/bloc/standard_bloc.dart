import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/api/api_client.dart';
import 'package:mood_journal/api/api_error.dart';
import 'package:mood_journal/bloc/state.dart';


class StandardPageBloc<S> extends BlocBase {
  final ApiClient apiClient;

  StandardPageBloc({
    @required ApiClient apiClient,
  })  : apiClient = apiClient;

  final baseController = StreamController<AppState<List<S>>>()
    ..add(InitialState());

  Stream<AppState<List<S>>> get stream => baseController.stream;

  @override
  void dispose() {
    baseController.close();
    super.dispose();
  }

  void makeCallForController<T>(
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
