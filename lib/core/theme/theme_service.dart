import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:zebra/core/services/cache/cache_constants.dart';
import 'package:zebra/core/services/cache/cache_service.dart';

import 'app_colors.dart';

class ThemeService extends GetxService {
  final _cacheService = Get.find<CacheService>();

  ThemeMode themeMode = ThemeMode.system;

  Future<ThemeService> init() async {
    var prefferredTheme = _cacheService.read(CacheKeys.prefferredTheme);

    if (prefferredTheme != null) {
      themeMode = ThemeMode.values.firstWhere((e) => e.name == prefferredTheme);
    }

    if (themeMode == ThemeMode.system) {
      themeMode = Get.isPlatformDarkMode ? ThemeMode.dark : ThemeMode.light;
    }

    _initNavigationBarColor();

    return this;
  }

  Future<void> changeTheme(ThemeMode mode) async {
    themeMode = mode;
    Get.changeThemeMode(mode);
    await _cacheService.write(CacheKeys.prefferredTheme, mode.name);
    _initNavigationBarColor();
  }

  Future<ThemeMode> toggleTheme() async {
    var theme = Get.isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await changeTheme(theme);
    return theme;
  }

  void _initNavigationBarColor() {
    var systemNavigationBarColor = themeMode == ThemeMode.light
        ? AppColors.light.scaffoldBackgroundColor
        : AppColors.dark.scaffoldBackgroundColor;

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: systemNavigationBarColor,
      ),
    );
  }
}
