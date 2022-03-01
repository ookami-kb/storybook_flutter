import 'package:flutter/material.dart';

import 'knobs.dart';

/// {@template nullable_knob}
/// A class that represents a nullable control knob.
/// {@endtemplate}
class NullableKnob<T> extends Knob<T?> {
  /// {@macro nullable_knob}
  NullableKnob({
    required String label,
    String? description,
    required KnobValue<T> knobValue,
    this.enabled = false,
  }) : super(
          label: label,
          description: description,
          knobValue: knobValue,
        );

  @visibleForTesting
  bool enabled;

  @override
  Widget build() => knobValue.build(
        label: label,
        description: description,
        nullable: true,
        enabled: enabled,
      );

  @override
  T? get value => enabled ? knobValue.value : null;

  @override
  set value(T? value) {
    if (value == null) {
      enabled = false;
    } else {
      enabled = true;
      knobValue.value = value;
    }
  }
}
