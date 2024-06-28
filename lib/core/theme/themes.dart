import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zebra/core/theme/size_extension.dart';
import 'package:zebra/core/theme/text_style_extension.dart';

import 'app_colors.dart';
import 'text_theme.dart';

class Themes {
  static final light = ThemeData.light(useMaterial3: true).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      AppColors.light,
      ...AppTextTheme.platformThemesLight,
    ],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
    ).copyWith(
      background: Colors.grey.shade50,
    ),
    scaffoldBackgroundColor: AppColors.light.scaffoldBackgroundColor,
    primaryColor: AppColors.light.primary,
    brightness: AppColors.light.brightness,
    dividerColor: AppColors.light.gray,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    dividerTheme: DividerThemeData(
      color: AppColors.light.gray,
      space: 0,
      thickness: 1,
    ),
    iconTheme: IconThemeData(
      size: 24.spMin,
    ),
    cardTheme: CardTheme(
      color: AppColors.light.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.light.gray,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.light.gray,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.light.gray,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: AppTextTheme.platformPrimaryLight.bodyLarge.medium,
      surfaceTintColor: Colors.transparent,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        surfaceTintColor: Colors.transparent,
        textStyle: AppTextTheme.platformPrimaryLight.bodyMedium.medium,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        backgroundColor: AppColors.light.primary,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        textStyle: AppTextTheme.platformPrimaryLight.bodyMedium.medium.copyWith(
          color: AppColors.light.white,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        backgroundColor: AppColors.light.primary,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        textStyle: AppTextTheme.platformPrimaryLight.bodyMedium.medium.copyWith(
          color: AppColors.light.white,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 16.rw),
        foregroundColor: AppColors.light.primary,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        side: BorderSide(
          width: 1,
          color: AppColors.light.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        textStyle: AppTextTheme.platformPrimaryLight.bodyLarge.medium,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.light.gray5,
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.light.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.light.error,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.light.error,
          width: 1,
        ),
      ),
    ),
  );

  static final dark = ThemeData.dark(useMaterial3: true).copyWith(
    extensions: <ThemeExtension<dynamic>>[
      AppColors.dark,
      ...AppTextTheme.platformThemesDark,
    ],
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,
    ).copyWith(
      background: Colors.grey[850]!,
    ),
    scaffoldBackgroundColor: AppColors.dark.scaffoldBackgroundColor,
    primaryColor: AppColors.dark.primary,
    brightness: Brightness.dark,
    dividerColor: AppColors.dark.gray,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    dividerTheme: DividerThemeData(
      color: AppColors.dark.gray,
      space: 0,
      thickness: 1,
    ),
    iconTheme: IconThemeData(
      size: 24.spMin,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: AppColors.dark.gray,
    ),
    cardTheme: CardTheme(
      color: AppColors.dark.gray,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.dark.gray,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.dark.gray,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.dark.gray,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: AppTextTheme.platformPrimaryDark.bodyLarge.medium,
      surfaceTintColor: Colors.transparent,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        surfaceTintColor: Colors.transparent,
        textStyle: AppTextTheme.platformPrimaryDark.bodyMedium.medium,
        splashFactory: NoSplash.splashFactory,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.rh, horizontal: 16.rw),
        backgroundColor: AppColors.dark.primary,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        textStyle: AppTextTheme.platformPrimaryDark.bodyLarge.medium.copyWith(
          color: Colors.white,
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.rh, horizontal: 16.rw),
        backgroundColor: AppColors.dark.primary,
        foregroundColor: Colors.white,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        textStyle: AppTextTheme.platformPrimaryDark.bodyLarge.medium.copyWith(
          color: Colors.white,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 16.rh),
        foregroundColor: AppColors.dark.primary,
        shadowColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        side: BorderSide(
          width: 1,
          color: AppColors.dark.primary,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36),
        ),
        textStyle: AppTextTheme.platformPrimaryDark.bodyLarge.medium,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.dark.gray,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.dark.primary,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.dark.error,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: AppColors.dark.error,
          width: 1,
        ),
      ),
    ),
  );
}
