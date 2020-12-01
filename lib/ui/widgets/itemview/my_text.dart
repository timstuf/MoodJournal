import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String _text;

  const MyText({
    Key key,
    @required String text,
  })  : _text = text,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style:
          GoogleFonts.raleway(color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 14),
    );
  }
}
