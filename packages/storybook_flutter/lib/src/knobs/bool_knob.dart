import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../plugins/knobs.dart';
import 'knobs.dart';

/// {@template bool_knob_value}
/// A knob value that allows the user to toggle a boolean value.
///
/// See also:
/// * [BooleanKnobWidget], which is the widget that displays the knob.
/// {@endtemplate}
class BoolKnobValue extends KnobValue<bool> {
  /// {@macro bool_knob_value}
  BoolKnobValue({
    required bool value,
  }) : super(value: value);

  @override
  Widget build({
    required String label,
    required String? description,
    required bool enabled,
    required bool nullable,
  }) =>
      BooleanKnobWidget(
        label: label,
        description: description,
        value: value,
        enabled: enabled,
        nullable: nullable,
      );
}

/// {@template boolean_knob_widget}
/// A knob widget that allows the user to toggle a boolean value.
///
/// The knob is displayed as a checkbox.
///
/// See also:
/// * [BoolKnob], which is the knob that this widget represents.
/// {@endtemplate}
class BooleanKnobWidget extends StatelessWidget {
  /// {@macro boolean_knob_widget}
  const BooleanKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    required this.enabled,
    required this.nullable,
  }) : super(key: key);

  final String label;
  final String? description;
  final bool value;
  final bool enabled;
  final bool nullable;

  @override
  Widget build(BuildContext context) => CheckboxListTile(
        tristate: nullable,
        title: Text(label),
        subtitle: description == null ? null : Text(description!),
        value: enabled ? value : null,
        onChanged: (v) => context.read<KnobsNotifier>().update(label, v),
        controlAffinity: ListTileControlAffinity.leading,
      );
}
