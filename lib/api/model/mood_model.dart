import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_journal/models/mood_number.dart';
import 'package:mood_journal/resources/utils.dart';

class MoodModel {
  int id;
  String name;
  MoodNumber moodNumber;
  String assetPath;
  bool isPressed;

  MoodModel({
    this.id,
    @required this.name,
  }) {
    _init();
  }

  MoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    _init();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }

  _init() {
    this.isPressed = false;
    this.assetPath = Utils.getAssetByName(name);
  }

  String get uniqueTag => "$name$hashCode";
}
