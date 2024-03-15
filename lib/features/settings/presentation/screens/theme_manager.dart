import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeType {
  light,
  dark,
}

class ThemeManager with ChangeNotifier {
  ThemeData _currentTheme = lightTheme;

  ThemeData get currentTheme => _currentTheme;

  Future<void> loadTheme() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      ThemeType? themeType = ThemeType.values[prefs.getInt('themeType') ?? 0];
      _setTheme(themeType);
    } catch (e) {
      // Обработка ошибок при доступе к SharedPreferences
      print("Error loading theme: $e");
    }
  }

  void _setTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        _currentTheme = lightTheme;
        break;
      case ThemeType.dark:
        _currentTheme = darkTheme;
        break;
    }
    notifyListeners();
  }

  Future<void> changeTheme(ThemeType themeType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('themeType', themeType.index);
    _setTheme(themeType);
  }
}
