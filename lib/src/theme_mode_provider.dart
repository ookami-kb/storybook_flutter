import 'package:flutter/material.dart';

class ThemeModeProvider extends ChangeNotifier {
  ThemeModeProvider(this._current);

  ThemeMode _current;

  ThemeMode get current => _current;

  void toggle() {
    _current = ThemeMode.values[(_current.index + 1) % ThemeMode.values.length];
    notifyListeners();
  }
}
