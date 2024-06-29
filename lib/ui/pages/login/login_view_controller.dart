import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/api/dto/login_request_dto.dart';
import 'package:zebra/core/services/auth/auth_service.dart';
import 'package:zebra/ui/widgets/loading_dialog_mixin/loading_dialog_mixin.dart';

class LoginViewController extends GetxController with LoadingDialogMixin {
  final _authService = Get.find<AuthService>();

  final formKey = GlobalKey<FormState>();
  final _autoValidateMode = Rx<AutovalidateMode>(AutovalidateMode.disabled);
  AutovalidateMode get autoValidateMode => _autoValidateMode.value;

  late PhoneController phoneController;

  @override
  void onInit() {
    phoneController = PhoneController(
      initialValue: PhoneNumber.parse("+90"),
    );
    super.onInit();
  }

  @override
  void onClose() {
    phoneController.dispose();
    super.onClose();
  }

  Future<void> login() async {
    try {
      if (formKey.currentState!.validate() == false ||
          phoneController.value.isValid() == false) {
        _autoValidateMode.value = AutovalidateMode.onUserInteraction;
        return;
      }
      showLoadingDialog();

      final res = await _authService.login(
        LoginRequestDto(
          phone: phoneController.value.international,
        ),
      );

      hideLoadingDialog();

      if (res.page == "pin") {
        Get.toNamed(
          Routes.loginCode,
          arguments: {
            "userId": res.user?.id,
            "phoneNumber": res.user?.phone,
          },
        );
      } else {
        Get.toNamed(Routes.register);
      }
    } catch (e) {
      AppLogger.error(e);
      AlertController.show(
        "Error",
        "An error occurred while logging in. Please try again.",
        TypeAlert.error,
      );
      hideLoadingDialog();
    }
  }
}
