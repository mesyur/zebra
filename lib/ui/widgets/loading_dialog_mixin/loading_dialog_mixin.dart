import 'package:get/get.dart';

import 'loading_dialog_view.dart';

mixin LoadingDialogMixin {
  final _loading = false.obs;

  void showLoadingDialog() {
    Get.dialog(
      const LoadingDialogView(),
      barrierDismissible: false,
    );

    _loading.value = true;
  }

  void hideLoadingDialog() {
    Get.back();

    _loading.value = false;
  }
}
