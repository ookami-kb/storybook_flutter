// ignore_for_file: match-getter-setter-field-names

import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

/// {@template nullable_knob}
/// A class that represents a nullable control knob.
/// {@endtemplate}
class NullableKnob<T> extends Knob<T?> {
  /// {@macro nullable_knob}
  NullableKnob({
    required super.label,
    super.description,
    required KnobValue<T> super.knobValue,
    this.enabled = true,
  });

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
