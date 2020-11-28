import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/bloc/state.dart';
import 'package:mood_journal/resources/strings.dart';

class BlocError<T> extends StatelessWidget {
  final AppState<T> currentState;

  const BlocError({Key key, this.currentState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (currentState is InitialState) {
      return Center(
        child: Text(Strings.initialTodoStateLabel),
      );
    }

    if (currentState is LoadingState) {
      return _buildLoader();
    }

    if (currentState is ErrorState) {
      return _buildError((currentState as ErrorState).errorMessage);
    }

    return _buildLoader();
  }

  Widget _buildLoader() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError(String errorMessage) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Text(
          errorMessage,
          style: TextStyle(
            fontSize: 24.0,
            color: Colors.red,
          ),
        ),
      ),
    );
  }
}
