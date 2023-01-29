import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knob_list_tile.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/plugins/knobs.dart';

/// {@template string_knob}
/// A knob that allows the user to edit a string value.
///
/// See also:
/// * [StringKnobWidget], which is the widget that displays the knob.
/// {@endtemplate}
class StringKnobValue extends KnobValue<String> {
  /// {@macro string_knob}
  StringKnobValue({
    required String value,
  }) : super(
          value: value,
        );

  @override
  Widget build({
    required String label,
    required String? description,
    required bool enabled,
    required bool nullable,
  }) =>
      StringKnobWidget(
        label: label,
        description: description,
        value: value,
        enabled: enabled,
        nullable: nullable,
      );
}

/// {@template string_knob_widget}
/// A knob widget that allows the user to edit a string value.
///
/// The knob is displayed as a [TextFormField].
///
/// See also:
/// * [StringKnobValue], which is the knob that this widget represents.
/// {@endtemplate}
class StringKnobWidget extends StatelessWidget {
  /// {@macro string_knob_widget}
  const StringKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.value,
    required this.enabled,
    required this.nullable,
  }) : super(key: key);

  final String label;
  final String? description;
  final String value;
  final bool enabled;
  final bool nullable;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final description = this.description;

    return KnobListTile(
      enabled: enabled,
      nullable: nullable,
      onToggled: (enabled) =>
          context.read<KnobsNotifier>().update(label, enabled ? value : null),
      title: TextFormField(
        decoration: InputDecoration(
          isDense: false,
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        initialValue: value,
        onChanged: (v) => context.read<KnobsNotifier>().update(label, v),
      ),
      subtitle: description != null
          ? Text(
              description,
              style: textTheme.bodyMedium?.copyWith(
                color: textTheme.bodySmall?.color,
              ),
            )
          : null,
    );
  }
}
