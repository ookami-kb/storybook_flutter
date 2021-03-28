import 'package:flutter/foundation.dart';

class PluginSettingsNotifier extends ChangeNotifier {
  final Map<Type, dynamic> _data = <Type, dynamic>{};

  T? get<T>(Type name) => _data[name] as T?;

  void set<T>(Type name, T? value) {
    _data[name] = value;
    notifyListeners();
  }
}
