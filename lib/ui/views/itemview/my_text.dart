import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final String _text;
  final double _size;
  final Color _color;
  final FontWeight _weight;

  const MyText({
    Key key,
    @required String text,
    @required double size,
    Color color,
    FontWeight weight,
    bool isCenter,
  })  : _text = text,
        _size = size,
        _color = color == null ? Colors.black : color,
        _weight = weight == null ? FontWeight.w600 : weight,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      textAlign: TextAlign.center,
      style: GoogleFonts.raleway(
          color: _color, fontWeight: _weight, fontSize: _size),
    );
  }
}
