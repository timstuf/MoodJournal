import 'package:flutter/material.dart';
import 'package:mood_journal/resources/strings.dart';

import 'my_text.dart';

class MoodJournalTitle extends StatelessWidget {
  final double _size;

  const MoodJournalTitle({
    @required double size,
  }) : _size = size;

  @override
  Widget build(BuildContext context) {
    return MyText(
      text: Strings.appName,
      size: _size,
      weight: FontWeight.w700,
    );
  }
}
