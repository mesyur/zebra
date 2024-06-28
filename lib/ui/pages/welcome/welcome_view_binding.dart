import 'package:get/get.dart';

import 'welcome_view_controller.dart';

class WelcomeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WelcomeViewController>(
      () => WelcomeViewController(),
    );
  }
}
