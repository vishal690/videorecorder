import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Common {
  static Future<File> changeFileNameOnly(File file, String newFileName) async {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return await file.rename(newPath);
  }

  static String getFileName() {
    var now = DateTime.now();
    var filename = (DateFormat('yyyyMMdd_HHmmss').format(now)) + ".mp4";

    // var curdt = DateTime.now();
    // String strday = curdt.day.toString();
    // if (curdt.day < 10) {
    //   strday = '0' + curdt.day.toString();
    // }
    // String strhour = curdt.hour.toString();
    // if (curdt.hour < 10) {
    //   strhour = '0' + curdt.hour.toString();
    // }
    // String strmonth = curdt.month.toString();
    // if (curdt.month < 10) {
    //   strmonth = '0' + curdt.month.toString();
    // }
    // var filename = curdt.year.toString() +
    //     strmonth +
    //     strday +
    //     "_" +
    //     strhour +
    //     curdt.minute.toString() +
    //     curdt.second.toString() +
    //     ".mp4";

    return filename;
  }

  static String formatDuration(int totalSeconds) {
    final duration = Duration(seconds: totalSeconds);
    final minutes = duration.inMinutes;
    final seconds = totalSeconds % 60;

    final minutesString = '$minutes'.padLeft(2, '0');
    final secondsString = '$seconds'.padLeft(2, '0');
    return '$minutesString:$secondsString';
  }
}
