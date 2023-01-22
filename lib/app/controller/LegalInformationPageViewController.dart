import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LegalInformationPageViewController extends GetxController{
  String titleText = '';
  String url = '';

  @override
  void onInit() {
    super.onInit();
    titleText = Get.arguments[0]["titleText"];
    url = Get.arguments[1]["url"];
  }

}