// Self Explainatory
// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  //! === Primary Brand Colors ===
  static const Color primary = Color(0xFF16A085);

  //! === Secondary Colors ===
  static const Color secondaryLight = Color(0xFFFBC02D);

  //! === Info Button ===
  static const Color info = Color(0xFF1E99DC);

  //! === Background / Surface ===
  static const Color background = Color(0xFFFFFFFF);
  //! === Error ===
  static const Color error = Color(0xFFD81B60);

  //! === Text Colors ===
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0x99111111); // 60% opacity
  static const Color textTertiary = Color(0x73111111); // 45% opacity
  static const Color textQuaternary = Color(0xA6111111);

  static const Color buttonDisabled = Colors.grey;

  static const Color success = Color(0xFF4CAF50);
}
