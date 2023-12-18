import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeString {
  String now() {
    final now = DateTime.now();
    final formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
    return formatter.format(now);
  }
}
