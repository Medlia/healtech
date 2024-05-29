import 'package:flutter/material.dart';
import 'package:healtech/core/colors.dart';

class CustomTheme {
  static ThemeData light = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.light,
      seedColor: CustomColors.primaryColor,
      primary: CustomColors.primaryColor,
    ),
    useMaterial3: true,
  );

  static ThemeData dark = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: CustomColors.primaryAccentColor,
      primary: CustomColors.primaryAccentColor,
    ),
    useMaterial3: true,
  );
}
