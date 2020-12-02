import 'package:flutter/material.dart';
import 'package:mood_journal/resources/utils.dart';

import 'my_text.dart';

class SignInUpButton extends StatelessWidget {
  final String _text;

  const SignInUpButton({
    @required String text,
  }) : _text = text;

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
      child: MyText(
        text: _text,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
