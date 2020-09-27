import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeModeProvider(this._current);

  ThemeMode _current;

  ThemeMode get current => _current;

  void toggleThemeMode() {
    if (_current == ThemeMode.system) {
      _current = ThemeMode.light;
    } else if (_current == ThemeMode.light) {
      _current = ThemeMode.dark;
    } else {
      _current = ThemeMode.system;
    }
    notifyListeners();
  }
}
