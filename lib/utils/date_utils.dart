import 'package:flutter/material.dart';

class DateUtilities {
  static const List<String> monthNamesShort = [
    "Ocak",
    "Şub.",
    "Mart",
    "Nis.",
    "May.",
    "Haz.",
    "Tem.",
    "Ağu.",
    "Eyl.",
    "Ekim",
    "Kas.",
    "Ara."
  ];

  static dateString(DateTime date) {
    date = date.toLocal();
    String dateString = '';

    dateString =
        (date.day < 10 ? '0' + date.day.toString() : date.day.toString());

    dateString += '.';

    dateString +=
        (date.month < 10 ? '0' + date.month.toString() : date.month.toString());

    dateString += '.';
    dateString += date.year.toString();

    dateString += "  ";

    dateString +=
        (date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString());

    dateString += ':';

    dateString += (date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString());

    return dateString;
  }

  static monthNameDayAndTimeString(DateTime date) {
    date = date.toLocal();
    String dateString = '';

    dateString = date.day.toString();

    dateString += " " + monthNamesShort[date.month - 1];
    dateString += " ";

    dateString +=
        (date.hour < 10 ? '0' + date.hour.toString() : date.hour.toString());

    dateString += ':';

    dateString += (date.minute < 10
        ? '0' + date.minute.toString()
        : date.minute.toString());

    return dateString;
  }

  static yearMonthNameAndDayString(DateTime date) {
    date = date.toLocal();
    String dateString = '';

    dateString = date.day.toString();

    dateString += " " + monthNamesShort[date.month - 1];

    dateString += " ";
    dateString += date.year.toString();

    return dateString;
  }

  static secondsToDurationString(double seconds) {
    int s = seconds.round();

    if (s == 0) {
      return "-";
    }

    int minutes = (seconds / 60).floor();
    int hours = (minutes / 60).floor();

    String res = "";
    if (hours > 0) {
      res += hours.toString() + "sa ";
    }

    if (minutes > 0) {
      res += (minutes % 60).toString() + "dk ";
    }

    res += (s % 60).toString() + "sn";

    return res;
  }

  static countString(double num) {
    if (num > 1000000) {
      var mn = (num / 1000000).floor();
      var dec = ((num / 1000000 - mn) * 100).round();

      return mn.toString() + "," + dec.toString() + "mil";
    }

    if (num > 1000) {
      var bn = (num / 1000).floor();
      var dec = ((num / 1000 - bn) * 100).round();

      return bn.toString() + "," + dec.toString() + "bin";
    }

    var fl = num.floor();
    var dec = ((num - fl) * 100).round();

    if (dec != 0) {
      return fl.toString() + "," + dec.toString();
    } else {
      return fl.toString();
    }
  }

  bool isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) {
      return false;
    }

    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
}

extension DateTimeExtensions on DateTime {
  DateTime setTimeOfDay(TimeOfDay time) {
    return DateTime(this.year, this.month, this.day, time.hour, time.minute);
  }
}
