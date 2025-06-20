import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier with WidgetsBindingObserver {
  ThemeMode _currentTheme = ThemeMode.system;

  ThemeNotifier() {
    WidgetsBinding.instance.addObserver(this);
  }

  ThemeMode get currentTheme => _currentTheme;

  bool get isDarkMode =>
      _currentTheme == ThemeMode.dark ||
          (_currentTheme == ThemeMode.system &&
              WidgetsBinding.instance.platformDispatcher.platformBrightness == Brightness.dark);

  void toggleTheme(bool isDark) {
    _currentTheme = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setSystemTheme() {
    _currentTheme = ThemeMode.system;
    notifyListeners();
  }

  @override
  void didChangePlatformBrightness() {
    if (_currentTheme == ThemeMode.system) {
      notifyListeners(); // Notify listeners when system theme changes
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
