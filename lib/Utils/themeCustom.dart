import 'package:flutter/material.dart';

/// Define a light and dark color theme. Then, read the user's
/// preferred ThemeMode (light, dark, or system default) from the
/// SettingsController to display the correct theme.
class ThemeCustom {
  /// themeDataLight
  ///
  /// Thème en light personnalisé
  static ThemeData themeDataLight = ThemeData(
    useMaterial3: false,
    primarySwatch: Colors.amber,
    // primaryColor: Colors.amber,
    brightness: Brightness.light,
  ).copyWith(
      inputDecorationTheme: const InputDecorationTheme()
          .copyWith(border: const OutlineInputBorder()));

  /// themeDataDark
  ///
  /// Thème en dark personnalisé
  static ThemeData themeDataDark = ThemeData(
    useMaterial3: false,
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.amber,
  ).copyWith(
      inputDecorationTheme: const InputDecorationTheme()
          .copyWith(border: const OutlineInputBorder()));
}
