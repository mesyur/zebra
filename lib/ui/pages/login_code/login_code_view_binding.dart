import 'package:get/get.dart';

import 'login_code_view_controller.dart';

class LoginCodeViewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginCodeViewController>(
      () => LoginCodeViewController(),
    );
  }
}
