import 'package:apk_analyzer/utils/constants/colors.dart';
import 'package:apk_analyzer/utils/constants/sizes.dart';
import 'package:apk_analyzer/utils/theme/custom/text_theme.dart';
import 'package:flutter/material.dart';

/// Class for Page Transtition Theme with static variable `snackerBarTheme`
class AppSnackerBarTheme {
  AppSnackerBarTheme._();

  /// Static variable for Snacker Bar Theme
  static SnackBarThemeData get lightTheme => SnackBarThemeData(
        elevation: 2,
        behavior: SnackBarBehavior.floating,
        actionTextColor: AppColors.textPrimary,
        closeIconColor: AppColors.textPrimary,
        backgroundColor: AppColors.primary,
        dismissDirection: DismissDirection.down,
        contentTextStyle: AppTypography.lightTextTheme.bodyLarge
            ?.copyWith(color: AppColors.textPrimary),
        insetPadding: EdgeInsets.symmetric(
          vertical: AppSizes.sm,
          horizontal: AppSizes.md,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSizes.md),
          ),
        ),
      );
}
