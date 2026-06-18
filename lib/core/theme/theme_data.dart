import 'package:cinema_app/core/theme/app_color.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: AppColors.electricBlue,
      secondary: AppColors.slate,
      surface: AppColors.lightSurface,
      onPrimary: Colors.white,
      onSurface: AppColors.lightText,
      error: AppColors.error,
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.electricBlue,
      secondary: AppColors.info,
      surface: AppColors.darkSurface,
      onPrimary: AppColors.darkBg, // Dark text on bright blue buttons
      onSurface: AppColors.darkText,
      error: AppColors.error,
    ),
  );
}