import 'package:flutter/widgets.dart';
import 'package:storybook_flutter/src/knobs/knob_value.dart';

/// {@template knob}
/// An class that represents a control knob.
/// {@endtemplate}
class Knob<T> {
  /// {@macro knob}
  Knob({
    required this.label,
    this.description,
    required this.knobValue,
  });

  /// The label of the knob.
  final String label;

  /// An optional description of the knob.
  final String? description;

  /// {@template knob.value}
  /// The current value of the knob.
  ///
  /// This may change as the user interacts with the knob.
  /// {@endtemplate}
  T get value => knobValue.value;

  /// {@macro knob.value}
  set value(T newValue) => knobValue.value = newValue;

  @protected
  KnobValue<T> knobValue;

  /// The build method for the knob.
  ///
  /// This method is responsible for building the widget that represents the
  /// knob.
  Widget build() => knobValue.build(
        label: label,
        description: description,
        nullable: false,
        enabled: true,
      );
}
