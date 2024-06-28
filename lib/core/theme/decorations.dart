import 'package:flutter/material.dart';
import 'package:zebra/core/theme/size_extension.dart';

enum ButtonSize {
  small,
  medium,
  large,
  xlarge,
  xxlarge,
}

enum ButtonShape {
  rounded,
  circle,
}

enum ButtonIconPosition {
  right,
  left,
}

class Decorations {
  static double pageHorizontalPadding = 20.rw;
  static double pageVerticalPadding = 20.rh;
  static const ScrollPhysics scrollPhysics = BouncingScrollPhysics();

  static EdgeInsets pagePadding = EdgeInsets.symmetric(
    horizontal: pageHorizontalPadding,
    vertical: pageVerticalPadding,
  );

  static double smallButtonHeight = 32.rh;
  static double mediumButtonHeight = 40.rh;
  static double largeButtonHeight = 48.rh;
  static double xlargeButtonHeight = 56.rh;
  static double xxlargeButtonHeight = 64.rh;

  static Map<ButtonSize, double> buttonSizeMap = {
    ButtonSize.small: smallButtonHeight,
    ButtonSize.medium: mediumButtonHeight,
    ButtonSize.large: largeButtonHeight,
    ButtonSize.xlarge: xlargeButtonHeight,
    ButtonSize.xxlarge: xxlargeButtonHeight,
  };

  static double buttonSize(ButtonSize size) => buttonSizeMap[size]!;
}
