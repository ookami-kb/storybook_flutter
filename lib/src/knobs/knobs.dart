import 'package:flutter/foundation.dart';

abstract class KnobsBuilder {
  bool boolean(String label, {bool initial = false});

  String text(String label, {String initial = ''});
}

class Knobs extends ChangeNotifier implements KnobsBuilder {
  final Map<String, dynamic> _knobs = <String, dynamic>{};

  @override
  bool boolean(String label, {bool initial = false}) =>
      _addKnob(label, initial);

  @override
  String text(String label, {String initial = ''}) => _addKnob(label, initial);

  T _addKnob<T>(String label, T value) =>
      _knobs.putIfAbsent(label, () => value) as T;

  void update<T>(String label, T value) {
    _knobs[label] = value;
    notifyListeners();
  }

  T get<T>(String label) => _knobs[label] as T;

  List<MapEntry<String, dynamic>> all() => _knobs.entries.toList();
}
