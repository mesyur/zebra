import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:zebra/core/constants/image_constants.dart';
import 'package:zebra/core/theme/decorations.dart';
import 'package:zebra/core/theme/size_extension.dart';
import 'package:zebra/core/theme/text_style_extension.dart';
import 'package:zebra/core/theme/theme_extension.dart';

import 'login_view_controller.dart';

class LoginView extends GetView<LoginViewController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: Decorations.pagePadding,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 48.rh),
                  Image.asset(
                    ImageConstants.logo,
                    height: 48.rh,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(height: 32.rh),
                  Text(
                    "Welcome Again",
                    style: context.appPrimaryTextTheme.titleMedium.bold,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 12.rh),
                  Text(
                    "Enter your phone number to continue",
                    style: context.appPrimaryTextTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.rh),
                  Form(
                    key: controller.formKey,
                    child: Obx(
                      () => PhoneFormField(
                        controller: controller.phoneController,
                        validator: PhoneValidator.compose([
                          PhoneValidator.required(context),
                          PhoneValidator.validMobile(context),
                        ]),
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.rh),
                          ),
                          fillColor: context.appColors.white,
                        ),
                        countrySelectorNavigator: const CountrySelectorNavigator
                            .draggableBottomSheet(),
                        enabled: true,
                        autovalidateMode: controller.autoValidateMode,
                        autofocus: true,
                        isCountrySelectionEnabled: true,
                        isCountryButtonPersistent: true,
                        countryButtonStyle: const CountryButtonStyle(
                          showDialCode: true,
                          showIsoCode: false,
                          showFlag: true,
                          flagSize: 24,
                        ),
                        // + all parameters of TextField
                        // + all parameters of FormField
                        // ...
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.rh,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.25.sw),
                    child: ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.rh),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.rh),
                        ),
                        backgroundColor: context.appColors.white,
                      ),
                      child: Text(
                        "Login",
                        style: context.appPrimaryTextTheme.bodyLarge.semibold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
