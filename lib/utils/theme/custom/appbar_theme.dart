import 'package:apk_analyzer/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:apk_analyzer/utils/theme/custom/text_theme.dart';

class AppAppBarTheme {
  static AppBarTheme get lightTheme => AppBarTheme(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.textPrimary,
        titleTextStyle: AppTypography.lightTextTheme.displaySmall,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.white,
        centerTitle: true,
        toolbarHeight: 56.h,
        elevation: 0,
      );
}
