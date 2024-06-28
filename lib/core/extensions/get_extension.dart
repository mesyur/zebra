import 'package:get/get.dart';

enum SnackbarType { info, success, error }

extension GetExtension on GetInterface {
  void closeUntilNamed(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }
}
