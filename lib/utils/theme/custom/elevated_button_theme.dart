import 'package:apk_analyzer/utils/constants/colors.dart';
import 'package:apk_analyzer/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

/// Class for Elevated Button Theme with static variable `lightTheme`
class AppButtonTheme {
  AppButtonTheme._();

  /// Static variable for Elevated Button (Dark)
  static ElevatedButtonThemeData get lightTheme => ElevatedButtonThemeData(
        style: ButtonStyle(
          splashFactory: NoSplash.splashFactory,
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.pressed)) {
                return AppColors.primary;
              }
              if (states.contains(WidgetState.hovered)) {
                return AppColors.primary;
              }
              if (states.contains(WidgetState.disabled)) {
                return AppColors.buttonDisabled;
              }
              return AppColors.primary;
            },
          ),
          shadowColor: WidgetStateProperty.all(Colors.transparent),
          elevation: WidgetStateProperty.all(0),
          minimumSize: WidgetStateProperty.all(const Size(358, 52)),
          padding: WidgetStateProperty.all(EdgeInsets.zero),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSizes.md),
            ),
          ),
        ),
      );
}
