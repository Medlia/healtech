import 'package:flutter/material.dart';
import 'package:healtech/theme/theme.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  ThemeData get theme => isDark ? CustomTheme.dark : CustomTheme.light;
  bool get isDark => _isDark;

  void toggle() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
