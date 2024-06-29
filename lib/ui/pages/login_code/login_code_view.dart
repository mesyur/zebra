import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zebra/core/constants/image_constants.dart';
import 'package:zebra/core/theme/decorations.dart';
import 'package:zebra/core/theme/size_extension.dart';
import 'package:zebra/core/theme/theme_extension.dart';

import 'login_code_view_controller.dart';
import 'widgets/custom_pinput.dart';

class LoginCodeView extends GetView<LoginCodeViewController> {
  const LoginCodeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginCodeView'),
        centerTitle: true,
      ),
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
                    "The activation code has been sent to the number",
                    style: context.appPrimaryTextTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.rh),
                  Form(
                    key: controller.formKey,
                    child: FractionallySizedBox(
                      widthFactor: 1,
                      child: CustomPinput(
                        controller: controller.pinController,
                        focusNode: controller.pinFocusNode,
                        onCompleted: controller.onCompletedCode,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 24.rh,
                  ),
                  TextButton(
                    onPressed: controller.resendLoginCode,
                    child: const Text("Resend code"),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
