import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/src/knobs/select_knob.dart';

/// {@template knob}
/// An abstract class that represents a control knob.
///
/// Consumers can extend this class to create custom knob types.
/// {@endtemplate}
abstract class Knob<T> {
  /// {@macro knob}
  Knob({
    required this.label,
    this.description,
    required this.value,
  });

  /// The label of the knob.
  final String label;

  /// An optional description of the knob.
  final String? description;

  /// The current value of the knob.
  ///
  /// This may change as the user interacts with the knob.
  T value;

  /// The build method for the knob.
  ///
  /// This method is responsible for building the widget that represents the
  /// knob.
  Widget build();
}

/// {@template knobs_builder}
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
/// {@endtemplate}
abstract class KnobsBuilder {
  /// {@macro knobs_builder}
  const KnobsBuilder();

  /// Creates checkbox with [label] and [initial] value.
  bool boolean({
    required String label,
    String? description,
    bool initial = false,
  });

  /// Creates text input field with [label] and [initial] value.
  String text({
    required String label,
    String? description,
    String initial = '',
  });

  /// Creates slider knob with `double` value.
  double slider({
    required String label,
    String? description,
    double initial = 0,
    double max = 1,
    double min = 0,
  });

  /// Creates slider knob with `int` value.
  int sliderInt({
    required String label,
    String? description,
    int initial = 0,
    int max = 100,
    int min = 0,
    int divisions = 100,
  });

  /// Creates select field with [label], [initial] value and list of [options].
  T options<T>({
    required String label,
    String? description,
    required T initial,
    List<Option<T>> options = const [],
  });
}
