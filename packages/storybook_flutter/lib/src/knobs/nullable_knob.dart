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
    bool enabled = false,
  })  : _enabled = enabled,
        super(
          label: label,
          description: description,
          knobValue: knobValue,
        );

  bool _enabled;

  @override
  Widget build() => knobValue.build(
        label: label,
        description: description,
        nullable: true,
        enabled: _enabled,
      );

  @override
  T? get value => _enabled ? knobValue.value : null;

  @override
  set value(T? value) {
    if (value == null) {
      _enabled = false;
    } else {
      _enabled = true;
      knobValue.value = value;
    }
  }
}
