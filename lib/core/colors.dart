import 'package:flutter/material.dart';

class CustomColors {
  CustomColors._();

  // App Colors
  static const Color primaryColor = Color.fromARGB(255, 4, 130, 194);
  static const Color secondaryColor = Color.fromARGB(255, 250, 232, 71);
  static const Color primaryAccentColor = Color.fromARGB(255, 70, 181, 237);
  static const Color secondaryAccentColor = Color(0xFFFFFE71);

  // Text Colors
  static const Color primaryText = Color(0xFF333333);
  static const Color secondaryText = Color(0xFF6C757D);
  static const Color whiteText = Colors.white;

  // Background Colors
  static const Color light = Color(0xFFF5F5F5);
  static const Color dark = Color(0xFF010203);

  // Background Container Colors
  static const Color lightContainer = Color(0xFFF6F6F6);
  static Color darkContainer = Colors.white.withOpacity(0.1);

  // Button Colors
  static const Color primaryButton = Color.fromARGB(255, 4, 130, 194);
  static const Color secondaryButton = Color(0xFF6C757D);
  static const Color disabledButton = Color(0xFFC4C4C4);

  // Border Colors
  static const Color primaryBorder = Color(0xFFD9D9D9);
  static const Color secondaryBorder = Color(0xFFE6E6E6);

  // Error and Validation Colors
  static const Color errorColor = Color(0xFFD32F2F);
  static const Color successColor = Color(0xFF388E3C);
  static const Color warningColor = Color(0xFFF57C00);
  static const Color infoColor = Color(0xFF1976D2);

  // Neutral Colors
  static const Color black = Color(0xFF232323);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);
}
