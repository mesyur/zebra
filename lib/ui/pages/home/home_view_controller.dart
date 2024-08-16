import 'package:get/get.dart';
import 'package:zebra/ui/widgets/loading_dialog_mixin/loading_dialog_mixin.dart';

class HomeViewController extends GetxController with LoadingDialogMixin {
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showLoading() {
    showLoadingDialog();

    Future.delayed(const Duration(seconds: 2), () {
      hideLoading();
    });
  }

  void hideLoading() {
    hideLoadingDialog();
  }
}
