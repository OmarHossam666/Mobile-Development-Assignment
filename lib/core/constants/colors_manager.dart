import 'package:flutter/material.dart';

abstract class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFF9F67FF);
  static const Color primaryDark = Color(0xFF5B21B6);

  static const Color textPrimary = Color(0xFF1F2937);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textLink = Color(0xFF7C3AED);

  static const Color background = Color(0xFFFFFFFF);
  static const Color backgroundSecondary = Color(0xFFF9FAFB);
  static const Color surface = Color(0xFFFFFFFF);

  static const Color border = Color(0xFFE5E7EB);
  static const Color borderFocused = Color(0xFF7C3AED);
  static const Color borderError = Color(0xFFEF4444);

  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  static const Color buttonPrimary = Color(0xFF7C3AED);
  static const Color buttonTextPrimary = Color(0xFFFFFFFF);
  static const Color buttonDisabled = Color(0xFFE5E7EB);
  static const Color buttonTextDisabled = Color(0xFF9CA3AF);

  static const Color checkboxActive = Color(0xFF7C3AED);
  static const Color checkboxBorder = Color(0xFFD1D5DB);

  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color divider = Color(0xFFE5E7EB);

  static const Color iconDefault = Color(0xFF6B7280);
  static const Color iconActive = Color(0xFF7C3AED);
}
