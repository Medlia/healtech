import 'package:flutter/material.dart';
import 'package:healtech/constants/colors.dart';

class CustomTheme {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: CustomColors.light,
    colorScheme: ColorScheme.fromSeed(
       brightness: Brightness.light,
      seedColor: CustomColors.primaryColor,
    ),
    useMaterial3: true
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: CustomColors.dark,
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: CustomColors.primaryAccentColor,
    ),
    useMaterial3: true,
  );
}
