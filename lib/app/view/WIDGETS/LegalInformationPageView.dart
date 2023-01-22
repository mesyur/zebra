import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../controller/LegalInformationPageViewController.dart';


class LegalInformationPageView extends GetView<LegalInformationPageViewController>{
  const LegalInformationPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.titleText),
        centerTitle: true,
      ),
      body: WebView(
        initialUrl: controller.url,
      ),
    );
  }
}
