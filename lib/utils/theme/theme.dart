import 'package:apk_analyzer/utils/constants/colors.dart';
import 'package:apk_analyzer/utils/theme/custom/appbar_theme.dart';
import 'package:apk_analyzer/utils/theme/custom/elevated_button_theme.dart';
import 'package:apk_analyzer/utils/theme/custom/text_theme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        primaryColor: AppColors.primary,
        brightness: Brightness.light,
        textTheme: AppTypography.lightTextTheme,
        elevatedButtonTheme: AppButtonTheme.lightTheme,
        appBarTheme: AppAppBarTheme.lightTheme,
      );
}
