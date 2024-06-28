import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pinput/pinput.dart';
import 'package:zebra/core/theme/size_extension.dart';
import 'package:zebra/core/theme/text_style_extension.dart';
import 'package:zebra/core/theme/theme_extension.dart';

class CustomPinput extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onCompleted;
  const CustomPinput({
    super.key,
    required this.controller,
    this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      height: 56.rh,
      width: 56.rw,
      textStyle: context.appPrimaryTextTheme.bodyLarge.semibold,
      decoration: BoxDecoration(
        color: context.appColors.gray5,
        borderRadius: BorderRadius.circular(16),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.appColors.primary),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
        /*  decoration: defaultPinTheme.decoration?.copyWith(
        color: context.appColors.gray5,
      ), */
        );

    return Directionality(
      // Specify direction if desired
      textDirection: TextDirection.ltr,
      child: Pinput(
        enabled: true,
        length: 4,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        /* validator: (s) {
          return s == '2222' ? null : 'Pin is incorrect';
        }, */
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        autofocus: true,
        onCompleted: onCompleted,
      ),
    );
  }
}
