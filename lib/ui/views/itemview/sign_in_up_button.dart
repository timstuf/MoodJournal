import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mood_journal/api/model/user_error.dart';
import 'package:mood_journal/api/model/user_model.dart';
import 'package:mood_journal/bloc/user_bloc.dart';
import 'package:mood_journal/resources/utils.dart';
import 'package:mood_journal/ui/pages/mood_history_page.dart';
import 'package:mood_journal/ui/widgets/error_dialog.dart';

import 'my_text.dart';

class SignInUpButton extends StatelessWidget {
  final String _text;
  final bool _isSignIn;
  final TextEditingController _userNameController;
  final TextEditingController _passwordController;
  final _bloc = BlocProvider.getBloc<UserPageBloc>();

  SignInUpButton({
    @required String text,
    @required bool isSignIn,
    @required TextEditingController userNameController,
    @required TextEditingController passwordController,
  })  : _text = text,
        _isSignIn = isSignIn,
        _userNameController = userNameController,
        _passwordController = passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Utils.getMainColor(), Utils.getDarkerMainColor()])),
        child: InkWell(
          child: MyText(
            text: _text,
            size: 20,
            color: Colors.white,
          ),
          onTap: () => _sign(context),
        ));
  }

  void _sign(BuildContext context) async {
    try {
      int userId;
      if (_isSignIn) {
        userId = await _bloc.apiClient.isUser(getUser());
      } else {
        userId = await _bloc.apiClient.registerUser(getUser());
      }

      Navigator.of(context).push(CupertinoPageRoute(
          builder: (_) => MoodHistoryPage(
                userId: userId,
              )));
    } on UserError catch (ex) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return ErrorDialog(message: "Error: " + ex.message.toString())
                .build(context);
          });
    }
  }

  UserModel getUser() {
    return new UserModel(
        name: _userNameController.text, password: _passwordController.text);
  }
}
