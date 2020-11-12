import 'package:flutter/material.dart';

class Mood {
  final String name;
  final Color color;

  const Mood({
    @required this.name,
    @required this.color,
  });

  String get uniqueTag => "$name$hashCode";
}