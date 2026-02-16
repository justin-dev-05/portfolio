import 'package:flutter/material.dart';

class AppColors {
  // Light Theme Colors
  static const Color primaryLight = Color(0xFF52CAF5); // Indigo
  static const Color secondaryLight = Color(0xFFE31D1A); // Rose
  static const Color accentLight = Color(0xFF06578E); // Emerald
  //  static const Color accentLight = Color(0xFF06578E); // Emerald
  static const Color backgroundLight = Color(0xFFF8FAFC);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color textPrimaryLight = Color(0xFF1E293B);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color transparent = Colors.transparent;

  // Dark Theme Colors
  static const Color primaryDark = Color(0xFF818CF8);
  static const Color secondaryDark = Color(0xFFFB7185);
  static const Color accentDark = Color(0xFF34D399);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);

  // Priority Colors
  static const Color lowPriority = Color(0xFF10B981);
  static const Color mediumPriority = Color(0xFFF59E0B);
  static const Color highPriority = Color(0xFFEF4444);

  static const Color surfaceGrey = Color(0xFFF1F5F9);
  static const Color surfaceGreyDark = Color(0xFF334155);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  static Color scaffoldBackground(bool isDark) =>
      isDark ? backgroundDark : backgroundLight;

  static Color surfaceColor(bool isDark) => isDark ? surfaceDark : white;

  static Color surfaceGreyColor(bool isDark) =>
      isDark ? surfaceGreyDark : surfaceGrey;

  static Color textPrimaryColor(bool isDark) =>
      isDark ? textPrimaryDark : textPrimaryLight;

  static Color textSecondaryColor(bool isDark) =>
      isDark ? textSecondaryDark : textSecondaryLight;
}
