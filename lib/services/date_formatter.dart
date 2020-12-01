import 'dart:convert';

import 'package:flutter/material.dart';

class DateFormatter {
  static var dayData =
      '{ "1" : "Mon", "2" : "Tue", "3" : "Wed", "4" : "Thur", "5" : "Fri", "6" : "Sat", "7" : "Sun" }';

  static var monthData =
      '{ "1" : "Jan", "2" : "Feb", "3" : "Mar", "4" : "Apr", "5" : "May", "6" : "June", "7" : "Jul", "8" : "Aug", "9" : "Sep", "10" : "Oct", "11" : "Nov", "12" : "Dec" }';

  static String dateFormatter(DateTime date) {
    return json.decode(dayData)['${date.weekday}'] +
        ", " +
        date.day.toString() +
        " " +
        json.decode(monthData)['${date.month}'] +
        ", " +
        date.year.toString();
  }

  static String timeFormatter(TimeOfDay time) {
    return time.hour.toString() + ":" + time.minute.toString();
  }

  static DateTime date(DateTime date, TimeOfDay time) {
    DateTime result =
        date.add(new Duration(hours: time.hour, minutes: time.minute));
    return result;
  }

  static String getTime(DateTime date) {
    return date.hour.toString() + ":" + date.minute.toString();
  }
}
