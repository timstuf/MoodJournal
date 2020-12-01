import 'package:flutter/foundation.dart';
import 'package:flutter/cupertino.dart';
import 'package:mood_journal/api/model/mood_model.dart';
import 'package:mood_journal/models/mood_number.dart';

class UserMoodModel{
  int id;
  MoodNumber moodNumber;
  String description;
  int userId;
  DateTime dateTime;
  MoodModel moodModel;

  UserMoodModel({
    this.id,
    this.description,
    @required this.moodNumber,
    @required this.userId,
    @required this.moodModel,
    @required this.dateTime,
  });

  UserMoodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    moodNumber = MoodNumber(number: json['moodNumber']);
    userId = json['userId'];
    moodModel = MoodModel.fromJson(json['moodPicture']);
    dateTime = DateTime.parse(json['dateTime']);
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['moodNumber'] = this.moodNumber.number;
    data['userId'] = this.userId;
    data['moodPicture'] = this.moodModel.toJson();
    data['dateTime'] = this.dateTime.toIso8601String();
    data['description'] = this.description;
    return data;
  }


  String get uniqueTag => "$id$hashCode";
}