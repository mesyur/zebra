import 'package:flutter/material.dart';
import 'package:flutter_dropdown_alert/alert_controller.dart';
import 'package:flutter_dropdown_alert/model/data_alert.dart';
import 'package:get/get.dart';
import 'package:zebra/core/logger/logger.dart';
import 'package:zebra/core/routes/app_pages.dart';
import 'package:zebra/core/services/api/dto/register_request_dto.dart';
import 'package:zebra/core/services/auth/auth_service.dart';
import 'package:zebra/ui/widgets/loading_dialog_mixin/loading_dialog_mixin.dart';

class RegisterViewController extends GetxController with LoadingDialogMixin {
  final _authService = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();

  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  final _termsAndConditions = false.obs;
  bool get termsAndConditions => _termsAndConditions.value;
  final String phone = Get.parameters["phone"] as String;

  @override
  void onInit() {
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    super.onClose();
  }

  void onChangeTermsAndConditions(bool? value) {
    if (value == null) {
      return;
    }

    _termsAndConditions.value = value;
  }

  Future<void> register() async {
    try {
      if (formKey.currentState!.validate() == false) {
        return;
      }
      showLoadingDialog();

      final res = await _authService.register(
        RegisterRequestDto(
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          phone: phone,
        ),
      );

      hideLoadingDialog();

      Get.offAndToNamed(
        Routes.loginCode,
        arguments: {
          "userId": res.id,
          "phoneNumber": res.phone,
        },
      );
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

  String? firstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your first name";
    }

    return null;
  }

  String? lastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter your last name";
    }

    return null;
  }

  String? termsAndConditionsValidator(Object? value) {
    if (value == null || value == false) {
      return "Please accept the terms and conditions";
    }

    return null;
  }
}
