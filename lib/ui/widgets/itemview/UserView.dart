import 'package:flutter/material.dart';
import 'package:mood_journal/api/model/user_model.dart';

class UserView extends StatelessWidget {
  final UserModel task;
  final Function onChanged;

  const UserView({
    Key key,
    @required this.task,
    @required this.onChanged,
  }) : super(key: key);

  Color _getStatusColor(BuildContext context) {
    final theme = Theme.of(context);
    return theme.primaryColorLight;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(2.0),
        child: Card(
          color: _getStatusColor(context),
        ));
  }

  Widget _buildColoredBox() {
    return ColoredBox(
        color: Colors.white,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildTaskCheck(),
              _buildAddTaskInfo(),
            ]));
  }

  Widget _buildAddTaskInfo() {
    return Padding(
        padding: EdgeInsets.fromLTRB(6, 0, 0, 2),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddText("1d 12h 34m 15s to the End"),
              _buildAddText("Category"),
            ]));
  }

  Widget _buildAddText(String text) {
    return Padding(
      padding: EdgeInsets.fromLTRB(2, 0, 0, 0),
      child: Text(text),
    );
  }

  Widget _buildTaskCheck() {
    return Row(
      children: <Widget>[
        Text(task.name),
      ],
    );
  }
}