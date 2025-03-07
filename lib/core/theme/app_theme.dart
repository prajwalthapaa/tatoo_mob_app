import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6C2F80);
  static const Color accentColor = Color(0xFFFFA500);
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color bottomNavigationBackgroundColor = Color(0xFFFCFAFE);
  static const Color borderColor = Color(0xFFF8F6F8);
  static const Color labelColor = Color(0xFF737074);
  static const Color labelColor2 = Color(0xFF535054);
  static const Color labelColor3 = Color(0xFF423F43);

  static const TextStyle _titleMedium = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle _bodyMedium = TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle _titleSmall = TextStyle(
    color: Colors.black,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle _labelMedium = TextStyle(
    color: labelColor,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle _labelSmall = TextStyle(
    color: labelColor,
    fontSize: 11,
    fontWeight: FontWeight.w400,
  );
  static const TextStyle _titleLarge = TextStyle(
    color: Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: bottomNavigationBackgroundColor,
        selectedItemColor: primaryColor,
        unselectedItemColor: labelColor,
        selectedLabelStyle: _titleSmall,
        unselectedLabelStyle: _labelSmall,
        selectedIconTheme: IconThemeData(
          color: primaryColor,
        ),
        unselectedIconTheme: IconThemeData(
          color: labelColor,
        ),
      ),
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        actionsIconTheme: IconThemeData(
          color: primaryColor,
        ),
        shadowColor: borderColor,
        elevation: 1,
        surfaceTintColor: Colors.transparent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
      textTheme: const TextTheme(
        titleSmall: _titleSmall,
        titleMedium: _titleMedium,
        titleLarge: _titleLarge,
        labelMedium: _labelMedium,
        labelSmall: _labelSmall,
        bodyMedium: _bodyMedium,
      ),
    );
  }
}
