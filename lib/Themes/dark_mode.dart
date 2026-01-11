import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
      primary: Color(0xFFF9FAFB),
      secondary: Color(0xFF3B82F6),
      background: Color(0xFF1F2937),
      surface: Color(0xFF111827),
      tertiary: Color(0xFF374151),
      inversePrimary: Color(0xFF1F2937)
  ),
  scaffoldBackgroundColor: Color(0xFF1F2937),
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFFF9FAFB),
    foregroundColor: Color(0xFF111827),
    elevation: 0,
  ),
);