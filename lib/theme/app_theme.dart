// lib/theme/app_theme.dart

import 'package:flutter/material.dart';

class AppTheme {
  static const Color black = Color(0xFF000000);
  static const Color gold = Color(0xFFFFD700);

  static ThemeData theme = ThemeData(
    fontFamily: "Poppins",
    scaffoldBackgroundColor: black,
    primaryColor: gold,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: black,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: gold,
        fontSize: 22,
        fontWeight: FontWeight.w700,
        fontFamily: 'Poppins',
      ),
      iconTheme: IconThemeData(color: gold),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontFamily: "Poppins",
      ),
      displayMedium: TextStyle(
        color: Colors.white70,
        fontSize: 18,
        fontFamily: "Poppins",
      ),
      bodyLarge: TextStyle(color: Colors.white, fontFamily: "Poppins"),
      bodyMedium: TextStyle(color: Colors.white70, fontFamily: "Poppins"),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: gold,
        foregroundColor: black,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
