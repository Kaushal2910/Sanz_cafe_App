import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBrown = Color(0xFF5B3A29);
  static const Color lightCream = Color(0xFFFFF8E7);
  static const Color darkText = Color(0xFF2E1C15);
  static const Color accentYellow = Color(0xFFF7C548);

  static ThemeData theme = ThemeData(
    scaffoldBackgroundColor: lightCream,
    fontFamily: 'Poppins',

    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBrown,
      foregroundColor: Colors.white,
      elevation: 0,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBrown,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    ),
  );
}
