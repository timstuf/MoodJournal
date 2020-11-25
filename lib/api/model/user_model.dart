import 'package:flutter/foundation.dart';
class UserModel {
  int id;
  String name;
  String password;

  UserModel({
    @required this.id,
    @required this.name,
    @required this.password,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['password'] = this.password;
    return data;
  }

}