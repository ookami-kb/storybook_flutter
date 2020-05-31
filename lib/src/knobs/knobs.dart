import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/src/knobs/bool_knob.dart';
import 'package:storybook_flutter/src/knobs/select_knob.dart';
import 'package:storybook_flutter/src/knobs/slider_knob.dart';
import 'package:storybook_flutter/src/knobs/string_knob.dart';

abstract class Knob<T> {
  Knob(this.label, this.value);

  final String label;
  T value;

  Widget build();
}

/// Provides helper methods for creating knobs: control elements
/// that can be used in stories to dynamically update its properties.
///
/// It's injected into a story builder, so you can use it there:
///
/// ```dart
///  Story(
///    name: 'Flat button',
///    builder: (_, k) => MaterialButton(
///      onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
///      child: Text(k.text('Text', initial: 'Flat button')),
///    ),
///  )
///  ```
abstract class KnobsBuilder {
  /// Creates checkbox with [label] and [initial] value.
  bool boolean(String label, {bool initial = false});

  /// Creates text input field with [label] and [initial] value.
  String text(String label, {String initial = ''});

  double slider(String label,
      {double initial = 0, double max = 100, double min = 0});

  /// Creates select field with [label], [initial] value and list of [options].
  T options<T>(String label, {T initial, List<Option<T>> options = const []});
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
  T options<T>(String label, {T initial, List<Option<T>> options = const []}) =>
      _addKnob(SelectKnob(label, initial, options));

  T _addKnob<T>(Knob<T> value) =>
      (_knobs.putIfAbsent(value.label, () => value) as Knob<T>).value;

  void update<T>(String label, T value) {
    print('$label changed to $value');
    _knobs[label].value = value;
    notifyListeners();
  }

  T get<T>(String label) => _knobs[label].value as T;

  List<Knob> all() => _knobs.values.toList();

  @override
  double slider(String label,
          {double initial = 0, double max = 100, double min = 0}) =>
      _addKnob(SliderKnob(label, value: initial, max: max, min: min));
}
