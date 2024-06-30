import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Formatter {
  static String formatNumber(num number, {int decimalDigits = 2}) {
    final formatter = NumberFormat.decimalPatternDigits(
      locale: Get.locale?.languageCode,
      decimalDigits: decimalDigits,
    );

    return formatter.format(number);
  }

  static String formatCurrency(
    num balance, {
    String? symbol,
    int minimumFractionDigits = 0,
    int decimalDigits = 2,
    String locale = "en_US",
  }) {
    final formatCurrency = NumberFormat.simpleCurrency(
      name: symbol ?? "USD",
      decimalDigits: decimalDigits,
      locale: locale,
    );

    formatCurrency.minimumFractionDigits = minimumFractionDigits;
    formatCurrency.maximumFractionDigits = decimalDigits;

    return formatCurrency.format(balance);
  }

  static String formatddMMMMyyyy(DateTime date) {
    return DateFormat('dd MMMM yyyy', Get.locale?.languageCode).format(date);
  }

  static String formatddMMMMyyyyhhmm(DateTime date) {
    return DateFormat('dd MMMM yyyy hh:mm', Get.locale?.languageCode)
        .format(date);
  }

  static int versionToNumber(String version) {
    final versionParts = version.split('+');
    final versionNumber = int.parse(versionParts[0].split('.').join());
    final buildNumber = int.parse(versionParts[1]);

    return (versionNumber * 1000 + buildNumber);
  }

  static String secondsToTimeString(int seconds) {
    final minutes = seconds ~/ 60;
    final secondsStr = (seconds % 60).toString().padLeft(2, '0');
    final minutesStr = minutes.toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }
}
