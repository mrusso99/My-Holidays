import 'package:flutter/material.dart';

class Constants {
  static String appName = "My Holidays";

  //Colors for theme
  static Color lightPrimary = Colors.white;
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.white;
  static Color lightBG = Colors.white;
  static Color darkBG = Colors.black;
  static Color badgeColor = Colors.red;

  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Colors.white,
      onPrimary: Colors.black,
      // Colors that are not relevant to AppBar in LIGHT mode:
      primaryVariant: Colors.grey,
      secondary: Colors.grey,
      secondaryVariant: Colors.grey,
      onSecondary: Colors.grey,
      background: Colors.grey,
      onBackground: Colors.grey,
      surface: Colors.grey,
      onSurface: Colors.grey,
      error: Colors.grey,
      onError: Colors.grey,
    ),
    // standard light theme
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      surface: Color(0x2E2E2E),
      onSurface: Colors.white,
      // Colors that are not relevant to AppBar in DARK mode:
      primary: Colors.grey,
      onPrimary: Colors.grey,
      primaryVariant: Colors.grey,
      secondary: Colors.grey,
      secondaryVariant: Colors.grey,
      onSecondary: Colors.grey,
      background: Colors.grey,
      onBackground: Colors.grey,
      error: Colors.grey,
      onError: Colors.grey,
    ),
  );
}
