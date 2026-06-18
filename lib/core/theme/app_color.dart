import 'package:flutter/material.dart';

class AppColors {
  // Brand Colors (Electric Blue & Deep Space)
  static const Color electricBlue = Color(0xFF00D4FF);// Vibrant Cyan/Blue
  static const Color deepSpace = Color(0xFF0A0E14);    // Almost black blue
  static const Color slate = Color(0xFF1E293B);        // Cool grey-blue
  
  // Light Mode (Crisp & Clean)
  static const Color lightBg = Color(0xFFF1F5F9);
  static const Color lightSurface = Colors.white;
  static const Color lightText = Color(0xFF0F172A);

  // Dark Mode (The "Neon Night" look)
  static const Color darkBg = Color(0xFF020617);      // Deep Navy Black
  static const Color darkSurface = Color(0xFF0F172A); // Slate Navy
  static const Color darkText = Color(0xFFF8FAFC);    // Off-white cool

  // Semantic Colors
  static const Color success = Color(0xFF2DD4BF);     // Teal-ish green
  static const Color error = Color(0xFFFB7185);       // Rose-red
  static const Color info = Color(0xFF38BDF8);
  static const Color red = Color.fromARGB(255, 206, 35, 61);       // Sky blue
}

extension ColorExtensions on BuildContext {
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  Color get primaryColor => Theme.of(this).colorScheme.primary;
  Color get secondaryColor => Theme.of(this).colorScheme.secondary;
  
  // Great for movie card backgrounds
  Color get surfaceColor => Theme.of(this).colorScheme.surface;
  
  // The 'On' colors ensure your text is always readable over the background
  Color get onSurfaceColor => Theme.of(this).colorScheme.onSurface;

  // Custom cool-tone helper
  Color get accentBlue => const Color(0xFF38BDF8);
}