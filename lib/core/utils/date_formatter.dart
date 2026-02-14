import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter._();

  static String formatShort(
    DateTime date, {
    String locale = 'en_US',
  }) {
    return DateFormat('dd MMM yyyy', locale).format(date);
  }

  static String formatLong(
    DateTime date, {
    String locale = 'en_US',
  }) {
    return DateFormat.yMMMMd(locale).format(date);
  }

 
  static String formatMonthYear(
    DateTime date, {
    String locale = 'en_US',
  }) {
    return DateFormat('MMM yyyy', locale).format(date);
  }

  static String formatWithTime(
    DateTime date, {
    String locale = 'en_US',
  }) {
    return DateFormat('dd MMM yyyy • HH:mm', locale)
        .format(date);
  }

  static String toIso(DateTime date) {
    return date.toIso8601String();
  }

  
  static DateTime fromIso(String iso) {
    return DateTime.parse(iso);
  }
}
