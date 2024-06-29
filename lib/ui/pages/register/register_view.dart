import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:zebra/core/constants/image_constants.dart';
import 'package:zebra/core/theme/decorations.dart';
import 'package:zebra/core/theme/size_extension.dart';
import 'package:zebra/core/theme/text_style_extension.dart';
import 'package:zebra/core/theme/theme_extension.dart';

import 'register_view_controller.dart';

class RegisterView extends GetView<RegisterViewController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RegisterView'),
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
                    "Kayıt için bilgilerinizi girin",
                    style: context.appPrimaryTextTheme.labelLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 24.rh),
                  Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: controller.firstNameController,
                          validator: controller.firstNameValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Ad",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.rh),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.rh),
                        TextFormField(
                          controller: controller.lastNameController,
                          validator: controller.lastNameValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            hintText: "Soyad",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.rh),
                            ),
                          ),
                        ),
                        SizedBox(height: 24.rh),
                        FormField(
                          validator: controller.termsAndConditionsValidator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          initialValue: controller.termsAndConditions,
                          builder: (FormFieldState<bool> state) =>
                              CheckboxListTile(
                            value: controller.termsAndConditions,
                            onChanged: (value) {
                              controller.onChangeTermsAndConditions(value);
                              state.didChange(value);
                            },
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(
                              "Kullanım koşullarını ve gizlilik politikasını kabul ediyorum",
                              style: context.appPrimaryTextTheme.bodySmall,
                            ),
                            subtitle: state.errorText != null
                                ? Text(
                                    state.errorText!,
                                    style: context.appPrimaryTextTheme.bodySmall
                                        .copyWith(color: context.appColors.red),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24.rh,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 0.25.sw),
                    child: ElevatedButton(
                      onPressed: controller.register,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.rh),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.rh),
                        ),
                        backgroundColor: context.appColors.white,
                      ),
                      child: Text(
                        "Kayıt ol",
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
