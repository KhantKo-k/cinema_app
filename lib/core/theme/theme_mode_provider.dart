import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'theme_mode_provider.g.dart';

@riverpod
class ThemeModeProvider extends _$ThemeModeProvider {
  @override
  ThemeMode build() => ThemeMode.system;

  void setThemeMode(ThemeMode themeMode) {
    state = themeMode;
  }

  void toggleThemeMode() {
  if (state == ThemeMode.dark) {
    state = ThemeMode.light;
  } else {
    // This catches both 'light' and 'system' and moves them to dark
    state = ThemeMode.dark;
  }
}
}