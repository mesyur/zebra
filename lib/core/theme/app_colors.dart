import 'package:flutter/material.dart';

import 'app_colors_extension.dart';

class AppColors {
  static Color primary = const Color(0xFF6200EE);
  static Color darkPrimary = const Color.fromARGB(255, 255, 247, 0);

  static AppColorsExtension light = const AppColorsExtension(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Color(0xFFF2F2F7),
    primary: Color(0xFF121212),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF4C89FF),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFFFFFFFF),
    onTertiary: Color(0xFFFFFFFF),
    error: Color(0xFFFB382D),
    onError: Color(0xFFFFFFFF),
    gray: Color(0xFF8E8E93),
    gray2: Color(0xFFAEAEB2),
    gray3: Color(0xFFC7C7CC),
    gray4: Color(0xFFD1D1D6),
    gray5: Color(0xFFE5E5EA),
    gray6: Color(0xFFF2F2F7),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    red: Color(0xFFFB382D),
    redContainer: Color(0xFFC63733),
    onRedContainer: Color(0xFFFF6161),
    yellow: Color(0xFFFAC800),
    yellowContainer: Color(0xFFCFA000),
    onYellowContainer: Color(0xFFFFD14D),
    green: Color(0xFF23C24B),
    greenContainer: Color(0xFF17A02E),
    onGreenContainer: Color(0xFF6DE360),
  );

  static AppColorsExtension dark = const AppColorsExtension(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xFF000000),
    primary: Color(0xFF121212),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF4C89FF),
    onSecondary: Color(0xFFFFFFFF),
    tertiary: Color(0xFFFFFFFF),
    onTertiary: Color(0xFFFFFFFF),
    error: Color(0xFFFB382D),
    onError: Color(0xFFFFFFFF),
    gray: Color(0xFF8E8E93),
    gray2: Color(0xFF636366),
    gray3: Color(0xFF48484A),
    gray4: Color(0xFF3A3A3C),
    gray5: Color(0xFF2C2C2E),
    gray6: Color(0xFF1C1C1E),
    white: Color(0xFFFFFFFF),
    black: Color(0xFF000000),
    red: Color(0xFFFB382D),
    redContainer: Color(0xFFC63733),
    onRedContainer: Color(0xFFFF6161),
    yellow: Color(0xFFFAC800),
    yellowContainer: Color(0xFFCFA000),
    onYellowContainer: Color(0xFFFFD14D),
    green: Color(0xFF23C24B),
    greenContainer: Color(0xFF17A02E),
    onGreenContainer: Color(0xFF6DE360),
  );
}
