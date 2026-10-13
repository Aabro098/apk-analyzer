import 'package:flutter/material.dart';
import 'package:apk_analyzer/utils/constants/sizes.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  AppTypography._();

  static TextTheme get lightTextTheme => TextTheme(
        headlineLarge: GoogleFonts.inter(
          fontSize: AppSizes.fontXXXl,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        headlineMedium: GoogleFonts.inter(
          fontSize: AppSizes.fontXXl,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        headlineSmall: GoogleFonts.inter(
          fontSize: AppSizes.fontLg,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: AppSizes.fontLg,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        titleMedium: GoogleFonts.inter(
          fontSize: AppSizes.fontBase,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
        titleSmall: GoogleFonts.inter(
          fontSize: AppSizes.fontMd,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: AppSizes.fontBase,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: AppSizes.fontMd,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        bodySmall: GoogleFonts.inter(
          fontSize: AppSizes.fontSm,
          fontWeight: FontWeight.normal,
          color: Colors.black87,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: AppSizes.fontMd,
          fontWeight: FontWeight.w500,
          color: Colors.black87,
        ),
        labelMedium: GoogleFonts.inter(
          fontSize: AppSizes.fontSm,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        labelSmall: GoogleFonts.inter(
          fontSize: AppSizes.fontXs,
          fontWeight: FontWeight.w300,
          color: Colors.black87,
        ),
      );
}
