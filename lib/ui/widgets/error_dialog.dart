import 'package:flutter/material.dart';
import 'package:mood_journal/resources/strings.dart';
import 'package:mood_journal/ui/views/itemview/my_text.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: MyText(text: Strings.error, size: 16, color: Colors.red),
      content: MyText(text: message, size: 14, color: Colors.red),
      actions: [
        MaterialButton(
          child: MyText(text: Strings.ok, size: 14),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
