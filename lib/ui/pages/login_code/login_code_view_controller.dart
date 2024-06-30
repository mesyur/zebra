import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/api/dto/check_login_code_request_dto.dart';
import 'package:zebra/core/services/api/dto/login_request_dto.dart';
import 'package:zebra/core/services/auth/auth_service.dart';
import 'package:zebra/ui/widgets/loading_dialog_mixin/loading_dialog_mixin.dart';

class LoginCodeViewController extends GetxController with LoadingDialogMixin {
  final _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();

  late final TextEditingController pinController;
  late final FocusNode pinFocusNode;

  late final int userId;
  late final String phoneNumber;

  late Timer _timer;
  final _timerText = 0.obs;
  int get timerText => _timerText.value;

  final _isResendButtonEnabled = false.obs;
  bool get isResendButtonEnabled => _isResendButtonEnabled.value;

  @override
  void onInit() {
    pinController = TextEditingController();
    pinFocusNode = FocusNode();
    userId = Get.arguments['userId'] as int;
    phoneNumber = Get.arguments['phoneNumber'] as String;
    startTimer();
    super.onInit();
  }

  @override
  void onClose() {
    pinController.dispose();
    pinFocusNode.dispose();
    _timer.cancel();
    super.onClose();
  }

  startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timerText.value = timer.tick;
      if (timer.tick == 120) {
        timer.cancel();
        _isResendButtonEnabled.value = true;
      }
    });
  }

  Future<void> onCompletedCode(String code) async {
    try {
      showLoadingDialog();
      await _authService.checkLoginCode(
        CheckLoginCodeRequestDto(
          pin: int.parse(code),
          userId: userId,
        ),
      );

      hideLoadingDialog();

      Get.toNamed(Routes.mainPage);
    } catch (e) {
      AppLogger.error(e);
      AlertController.show("Error", e.toString(), TypeAlert.error);
      hideLoadingDialog();
      pinController.clear();
      pinFocusNode.requestFocus();
    }
  }

  Future<void> resendLoginCode() async {
    try {
      showLoadingDialog();
      await _authService.resendLoginCode(LoginRequestDto(phone: phoneNumber));

      _isResendButtonEnabled.value = false;
      startTimer();

      hideLoadingDialog();
      AlertController.show("Success", "Code has been sent", TypeAlert.success);
    } catch (e) {
      AppLogger.error(e);
      AlertController.show("Error", e.toString(), TypeAlert.error);
      hideLoadingDialog();
    }
  }
}
