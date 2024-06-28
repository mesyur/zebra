// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

@immutable
class AppColorsExtension extends ThemeExtension<AppColorsExtension> {
  const AppColorsExtension({
    required this.gray,
    required this.gray2,
    required this.gray3,
    required this.gray4,
    required this.gray5,
    required this.gray6,
    required this.white,
    required this.black,
    required this.brightness,
    required this.scaffoldBackgroundColor,
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.error,
    required this.onError,
    required this.red,
    required this.redContainer,
    required this.onRedContainer,
    required this.yellow,
    required this.yellowContainer,
    required this.onYellowContainer,
    required this.green,
    required this.greenContainer,
    required this.onGreenContainer,
  });

  final Brightness brightness;
  final Color scaffoldBackgroundColor;
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;
  final Color error;
  final Color onError;
  final Color white;
  final Color black;
  final Color gray;
  final Color gray2;
  final Color gray3;
  final Color gray4;
  final Color gray5;
  final Color gray6;
  final Color red;
  final Color redContainer;
  final Color onRedContainer;
  final Color yellow;
  final Color yellowContainer;
  final Color onYellowContainer;
  final Color green;
  final Color greenContainer;
  final Color onGreenContainer;

  @override
  AppColorsExtension copyWith({
    Brightness? brightness,
    Color? scaffoldBackgroundColor,
    Color? primary,
    Color? onPrimary,
    Color? secondary,
    Color? onSecondary,
    Color? tertiary,
    Color? onTertiary,
    Color? error,
    Color? onError,
    Color? gray,
    Color? gray2,
    Color? gray3,
    Color? gray4,
    Color? gray5,
    Color? gray6,
    Color? white,
    Color? black,
    Color? red,
    Color? redContainer,
    Color? onRedContainer,
    Color? yellow,
    Color? yellowContainer,
    Color? onYellowContainer,
    Color? green,
    Color? greenContainer,
    Color? onGreenContainer,
  }) {
    return AppColorsExtension(
      brightness: brightness ?? this.brightness,
      scaffoldBackgroundColor:
          scaffoldBackgroundColor ?? this.scaffoldBackgroundColor,
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      secondary: secondary ?? this.secondary,
      onSecondary: onSecondary ?? this.onSecondary,
      tertiary: tertiary ?? this.tertiary,
      onTertiary: onTertiary ?? this.onTertiary,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      gray: gray ?? this.gray,
      gray2: gray2 ?? this.gray2,
      gray3: gray3 ?? this.gray3,
      gray4: gray4 ?? this.gray4,
      gray5: gray5 ?? this.gray5,
      gray6: gray6 ?? this.gray6,
      red: red ?? this.red,
      white: white ?? this.white,
      black: black ?? this.black,
      redContainer: redContainer ?? this.redContainer,
      onRedContainer: onRedContainer ?? this.onRedContainer,
      yellow: yellow ?? this.yellow,
      yellowContainer: yellowContainer ?? this.yellowContainer,
      onYellowContainer: onYellowContainer ?? this.onYellowContainer,
      green: green ?? this.green,
      greenContainer: greenContainer ?? this.greenContainer,
      onGreenContainer: onGreenContainer ?? this.onGreenContainer,
    );
  }

  @override
  AppColorsExtension lerp(AppColorsExtension? other, double t) {
    if (other is! AppColorsExtension) {
      return this;
    }
    return AppColorsExtension(
      brightness: t < 0.5 ? brightness : other.brightness,
      scaffoldBackgroundColor: Color.lerp(
              scaffoldBackgroundColor, other.scaffoldBackgroundColor, t) ??
          scaffoldBackgroundColor,
      primary: Color.lerp(primary, other.primary, t) ?? primary,
      onPrimary: Color.lerp(onPrimary, other.onPrimary, t) ?? onPrimary,
      secondary: Color.lerp(secondary, other.secondary, t) ?? secondary,
      onSecondary: Color.lerp(onSecondary, other.onSecondary, t) ?? onSecondary,
      tertiary: Color.lerp(tertiary, other.tertiary, t) ?? tertiary,
      onTertiary: Color.lerp(onTertiary, other.onTertiary, t) ?? onTertiary,
      error: Color.lerp(error, other.error, t) ?? error,
      onError: Color.lerp(onError, other.onError, t) ?? onError,
      gray: Color.lerp(gray, other.gray, t) ?? gray,
      gray2: Color.lerp(gray2, other.gray2, t) ?? gray2,
      gray3: Color.lerp(gray3, other.gray3, t) ?? gray3,
      gray4: Color.lerp(gray4, other.gray4, t) ?? gray4,
      gray5: Color.lerp(gray5, other.gray5, t) ?? gray5,
      gray6: Color.lerp(gray6, other.gray6, t) ?? gray6,
      white: Color.lerp(white, other.white, t) ?? white,
      black: Color.lerp(black, other.black, t) ?? black,
      red: Color.lerp(red, other.red, t) ?? red,
      redContainer:
          Color.lerp(redContainer, other.redContainer, t) ?? redContainer,
      onRedContainer:
          Color.lerp(onRedContainer, other.onRedContainer, t) ?? onRedContainer,
      yellow: Color.lerp(yellow, other.yellow, t) ?? yellow,
      yellowContainer: Color.lerp(yellowContainer, other.yellowContainer, t) ??
          yellowContainer,
      onYellowContainer:
          Color.lerp(onYellowContainer, other.onYellowContainer, t) ??
              onYellowContainer,
      green: Color.lerp(green, other.green, t) ?? green,
      greenContainer:
          Color.lerp(greenContainer, other.greenContainer, t) ?? greenContainer,
      onGreenContainer:
          Color.lerp(onGreenContainer, other.onGreenContainer, t) ??
              onGreenContainer,
    );
  }

  // Optional
  @override
  String toString() {
    return 'AppColors(brightness: $brightness, scaffoldBackgroundColor: $scaffoldBackgroundColor, primary: $primary, onPrimary: $onPrimary, secondary: $secondary, onSecondary: $onSecondary, tertiary: $tertiary, onTertiary: $onTertiary, error: $error, onError: $onError, gray: $gray, gray2: $gray2,gray3: $gray3,gray4: $gray4,gray5: $gray5,gray6: $gray6, red: $red,redContainer: $redContainer, onRedContainer: $onRedContainer, yellow: $yellow, yellowContainer: $yellowContainer, onYellowContainer: $onYellowContainer, green: $green, greenContainer: $greenContainer, onGreenContainer: $onGreenContainer,)';
  }
}
