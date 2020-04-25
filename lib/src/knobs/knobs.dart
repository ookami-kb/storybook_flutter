import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/src/knobs/bool_knob.dart';
import 'package:storybook_flutter/src/knobs/select_knob.dart';
import 'package:storybook_flutter/src/knobs/string_knob.dart';

abstract class Knob<T> {
  Knob(this.label, this.value);

  final String label;
  T value;

  Widget build();
}

abstract class KnobsBuilder {
  bool boolean(String label, {bool initial = false});

  String text(String label, {String initial = ''});

  T options<T>(String label, {T initial, List<Select<T>> options});
}

class Knobs extends ChangeNotifier implements KnobsBuilder {
  final Map<String, Knob> _knobs = <String, Knob>{};

  @override
  bool boolean(String label, {bool initial = false}) =>
      _addKnob(BoolKnob(label, initial));

  @override
  String text(String label, {String initial = ''}) =>
      _addKnob(StringKnob(label, initial));

  @override
  T options<T>(String label, {T initial, List<Select<T>> options}) =>
      _addKnob(SelectKnob(label, initial, options));

  T _addKnob<T>(Knob<T> value) =>
      (_knobs.putIfAbsent(value.label, () => value) as Knob<T>).value;

  void update<T>(String label, T value) {
    _knobs[label].value = value;
    notifyListeners();
  }

  T get<T>(String label) => _knobs[label].value as T;

  List<Knob> all() => _knobs.values.toList();
}
