// core/theme.dart
import 'package:flutter/material.dart';

import 'light_colors.dart';

class AppTheme {
  // Define color constants
  static const Color primaryColor = Color(0xFFC53030);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color darkGradientColor = Colors.black;
  static const Color errorColor = Color(0xFFC53030);
  static const Color disabledColor = Colors.grey;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: LightColor.primaryColor,
        surface: LightColor.backgroundColor,
        error: LightColor.errorColor,
        onPrimary: Colors.white,
        onSurface: Colors.black,
        onSecondary: Colors.white70,
      ),
      scaffoldBackgroundColor: LightColor.backgroundColor,
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.w700,
          letterSpacing: 2,
          color: Colors.white,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold, // 700
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFFC53030),
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal, // w400
          color: Color(0xFF141414),
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white70,
        ),
        displayMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: LightColor.primaryColor,
        ),
        displayLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w700,
          color: Color(0xFF4E4B66),
        ),
        labelMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: Color(0xFF6E7191),
        ),
        labelLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: Color(0xFF141414)
        ),
        labelSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFF363636),
        )
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFFFFFF),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: LightColor.backgroundColor,
        selectedItemColor: LightColor.primaryColor,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
      ),
      listTileTheme: const ListTileThemeData(
        contentPadding: EdgeInsets.zero,
        minLeadingWidth: 16,
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      cardTheme: CardThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
      ),
      splashFactory: NoSplash.splashFactory,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          backgroundColor: Color(0xFFC53030),
          foregroundColor: Color(0xFFFFFCFC),
          textStyle: TextStyle(fontSize: 16),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color(0xFFFFFFFF),
        filled: true,
        hintStyle: const TextStyle(color: Color(0xFFA0A0A0)),
        // light gray for hint text
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD3D3D3)),
          // gray border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD3D3D3)), // same gray on focus
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFFD3D3D3)),
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.selected)) {
            return Color(0xFFC53030); // Color when selected
          }
          return Color(0xFFD3D3D3);
        }),
      ),// Gray border for unselected
    );
  }

  static ThemeData get darkTheme {
    return lightTheme;
  }

  static ThemeData getTheme({required bool isDarkMode}) {
    return isDarkMode ? darkTheme : lightTheme;
  }
}
