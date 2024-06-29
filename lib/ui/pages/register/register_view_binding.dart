import 'package:get/get.dart';

import 'register_view_controller.dart';

class RegisterViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterViewController>(
      () => RegisterViewController(),
    );
  }
}
