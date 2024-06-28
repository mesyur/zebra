import 'package:flutter/material.dart';
import 'package:zebra/core/theme/app_colors.dart';
import 'package:zebra/core/theme/app_colors_extension.dart';
import 'package:zebra/core/theme/text_theme.dart';
import 'package:zebra/core/theme/text_theme_extension.dart';
import 'package:zebra/l10n/app_localizations.dart';

extension AppThemeExtension on ThemeData {
  /// Usage example: Theme.of(context).appColors;
  AppColorsExtension get appColors =>
      extension<AppColorsExtension>() ?? AppColors.light;

  PrimaryTextThemeExtension get appPrimaryTextTheme {
    final theme = extension<PrimaryTextThemeExtension>();

    return theme ?? AppTextTheme.platformPrimaryLight;
  }

  SecondaryTextThemeExtension get appSecondaryTextTheme {
    final theme = extension<SecondaryTextThemeExtension>();

    return theme ?? AppTextTheme.platformSecondaryLight;
  }
}

extension AppTextAndColorExtension on BuildContext {
  AppColorsExtension get appColors => Theme.of(this).appColors;

  PrimaryTextThemeExtension get appPrimaryTextTheme =>
      Theme.of(this).appPrimaryTextTheme;

  SecondaryTextThemeExtension get appSecondaryTextTheme =>
      Theme.of(this).appSecondaryTextTheme;

  AppLocalizations get localization => AppLocalizations.of(this)!;
}
