import 'package:flutter/material.dart';

class Mood {
  final String name;
  final String imageAssetPath;

  const Mood({
    @required this.name,
    @required this.imageAssetPath,
  });

  String get uniqueTag => "$name$hashCode";
}