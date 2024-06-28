// ignore_for_file: public_member_api_docs, sort_constructors_first, constant_identifier_names
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'text_theme_extension.dart';

class AppFontFamily {
  static const String INTER = 'Century';
  static const String SF_PRO_DISPLAY = 'Century';
  static const String SF_PRO_ROUNDED = 'Century';
}

class AppTextTheme {
  static const FontWeight defaultFontWeight = FontWeight.w400;

  static final List<dynamic> platformThemesLight = Platform.isIOS
      ? [primaryLightIOS, secondaryLightIOS]
      : [primaryLight, secondaryLight];

  static final List<dynamic> platformThemesDark = Platform.isIOS
      ? [primaryDarkIOS, secondaryDarkIOS]
      : [primaryDark, secondaryDark];

  static final PrimaryTextThemeExtension platformPrimaryLight =
      Platform.isIOS ? primaryLightIOS : primaryLight;

  static final PrimaryTextThemeExtension platformPrimaryDark =
      Platform.isIOS ? primaryDarkIOS : primaryDark;

  static final SecondaryTextThemeExtension platformSecondaryLight =
      Platform.isIOS ? secondaryLightIOS : secondaryLight;

  static final SecondaryTextThemeExtension platformSecondaryDark =
      Platform.isIOS ? secondaryDarkIOS : secondaryDark;

  static final PrimaryTextThemeExtension primaryLight =
      PrimaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      fontFamily: AppFontFamily.INTER,
      color: AppColors.light.black,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static final PrimaryTextThemeExtension primaryDark =
      PrimaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      fontFamily: AppFontFamily.INTER,
      color: AppColors.dark.white,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static final SecondaryTextThemeExtension secondaryLight =
      SecondaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      fontFamily: AppFontFamily.INTER,
      color: AppColors.light.black,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static final SecondaryTextThemeExtension secondaryDark =
      SecondaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      fontFamily: AppFontFamily.INTER,
      color: AppColors.dark.white,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static final PrimaryTextThemeExtension primaryLightIOS =
      PrimaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      color: AppColors.light.black,
      fontFamily: AppFontFamily.SF_PRO_DISPLAY,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static final PrimaryTextThemeExtension primaryDarkIOS =
      PrimaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      color: AppColors.light.black,
      fontFamily: AppFontFamily.SF_PRO_DISPLAY,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static final SecondaryTextThemeExtension secondaryLightIOS =
      SecondaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      color: AppColors.light.black,
      fontFamily: AppFontFamily.SF_PRO_ROUNDED,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static final SecondaryTextThemeExtension secondaryDarkIOS =
      SecondaryTextThemeExtension.fromTextTheme(
    _baseTheme(
      color: AppColors.light.black,
      fontFamily: AppFontFamily.SF_PRO_ROUNDED,
      defaultFontWeight: defaultFontWeight,
    ),
  );

  static TextTheme _baseTheme({
    required Color color,
    required String fontFamily,
    required FontWeight defaultFontWeight,
  }) =>
      TextTheme(
        displayLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 47.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        displayMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 47.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        displaySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 47.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        headlineLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 47.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        headlineMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 47.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        headlineSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 34.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        titleLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 33.spMin,
          fontWeight: defaultFontWeight,
          color: color,
          letterSpacing: 0.25,
        ),
        titleMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 24.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        titleSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 20.spMin,
          fontWeight: defaultFontWeight,
          color: color,
          letterSpacing: 0.15,
        ),
        bodyLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 16.spMin,
          fontWeight: defaultFontWeight,
          color: color,
          letterSpacing: 0.25,
          height: 1.3.spMin,
        ),
        bodyMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14.spMin,
          fontWeight: defaultFontWeight,
          color: color,
          letterSpacing: 1.25,
        ),
        bodySmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 14.spMin,
          fontWeight: defaultFontWeight,
          color: color,
          letterSpacing: 0.25,
        ),
        labelLarge: TextStyle(
          fontFamily: fontFamily,
          fontSize: 12.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
        labelMedium: TextStyle(
          fontFamily: fontFamily,
          fontSize: 10.spMin,
          fontWeight: defaultFontWeight,
          color: color,
          letterSpacing: 0.4,
        ),
        labelSmall: TextStyle(
          fontFamily: fontFamily,
          fontSize: 10.spMin,
          fontWeight: defaultFontWeight,
          color: color,
        ),
      );
}
