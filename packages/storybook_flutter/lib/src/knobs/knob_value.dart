import 'package:flutter/widgets.dart';

/// {@template knob}
/// An abstract class that represents a control knob.
///
/// Consumers can extend this class to create custom knob types.
/// {@endtemplate}
abstract class KnobValue<T> {
  /// {@macro knob}
  KnobValue({
    required this.value,
  });

  /// The current value of the knob.
  ///
  /// This may change as the user interacts with the knob.
  T value;

  /// The build method for the knob.
  ///
  /// This method is responsible for building the widget that represents the
  /// knob.
  Widget build({
    required String label,
    required String? description,
    required bool nullable,
    required bool enabled,
  });
}
