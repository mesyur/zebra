import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateFormatter {
  static DateTime getFirstDayOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday - 1));
  }

  static DateTime getLastDayOfWeek(DateTime date) {
    return date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
  }

  static String startEndOfWeek(DateTime date) {
    var formatter = DateFormat('dd MMM', Get.locale?.languageCode);
    return '${formatter.format(getFirstDayOfWeek(date))} - ${formatter.format(getLastDayOfWeek(date))}';
  }

  static String formatddMMMMyyyy(DateTime date) {
    return DateFormat('dd MMMM yyyy', Get.locale?.languageCode).format(date);
  }

  static bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  static bool isNotSameDay(DateTime date1, DateTime date2) {
    return !isSameDay(date1, date2);
  }

  static DateTime startOfWeek(DateTime date) {
    final startOfWeek = date.subtract(Duration(days: date.weekday - 1));
    return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
  }
}
