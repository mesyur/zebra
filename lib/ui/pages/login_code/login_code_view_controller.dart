import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/api/dto/check_login_code_request_dto.dart';
import 'package:zebra/core/services/auth/auth_service.dart';
import 'package:zebra/help/loadingClass.dart';

class LoginCodeViewController extends GetxController with LoadingDialog {
  final _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();

  late final TextEditingController pinController;
  late final int userId;

  @override
  void onInit() {
    pinController = TextEditingController();
    userId = Get.arguments['userId']!;
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }

  Future<void> onCompletedCode(String code) async {
    try {
      showDialogBox();
      await _authService.checkLoginCode(
        CheckLoginCodeRequestDto(
          pin: int.parse(code),
          userId: userId,
        ),
      );

      hideDialog();

      Get.toNamed(Routes.mainPage);
    } catch (e) {
      AppLogger.error(e);
      AlertController.show("Error", e.toString(), TypeAlert.error);
      hideDialog();
    }
  }
}
