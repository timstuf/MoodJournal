import 'package:flutter/material.dart';

import 'my_text.dart';

class EntryField extends StatelessWidget {
  final TextEditingController _controller;
  final String _title;
  final bool _isPassword;

  const EntryField({
    Key key,
    @required String title,
    @required bool isPassword,
    @required TextEditingController controller,
  })  : _title = title,
        _isPassword = isPassword,
        _controller = controller,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          MyText(text: _title, size: 15),
          SizedBox(
            height: 10,
          ),
          TextField(
            obscureText: _isPassword,
            controller: _controller,
          )
        ],
      ),
    );
  }
}
