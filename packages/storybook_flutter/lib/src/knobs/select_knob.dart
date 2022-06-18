import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knob_list_tile.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/plugins/knobs.dart';

/// {@template select_knob}
/// A knob that allows the user to select an option from a list of options.
///
/// See also:
/// * [Option], which represents a single option in the list.
/// * [SelectKnobWidget], which is the widget that displays the knob.
/// {@endtemplate}
class SelectKnobValue<T> extends KnobValue<T> {
  /// {@macro select_knob}
  SelectKnobValue({
    required T value,
    required this.options,
  }) : super(
          value: value,
        );

  /// The list of options that the user can select from.
  ///
  /// See also:
  /// * [Option], which represents a single option in the list.
  final List<Option<T>> options;

  @override
  Widget build({
    required String label,
    required String? description,
    required bool enabled,
    required bool nullable,
  }) =>
      SelectKnobWidget<T>(
        label: label,
        description: description,
        value: value,
        values: options,
        enabled: enabled,
        nullable: nullable,
      );
}

/// {@template option}
/// Represents a single option for a `SelectKnob`.
///
/// Every option will be displayed in a dropdown menu.
/// {@endtemplate}
class Option<T> {
  /// {@macro option}
  const Option({
    required this.label,
    this.description,
    required this.value,
  });

  /// The label that will be displayed in the dropdown menu.
  final String label;

  /// An optional description that will be displayed in the dropdown menu.
  final String? description;

  /// The value that will be returned when the user selects this option.
  final T value;
}

/// {@template select_knob_widget}
/// A knob widget that allows the user to select a value from a list of options.
///
/// The knob is displayed as a dropdown menu.
///
/// See also:
/// * [SelectKnobValue], which is the knob that this widget represents.
/// {@endtemplate}
class SelectKnobWidget<T> extends StatelessWidget {
  /// {@macro select_knob_widget}
  const SelectKnobWidget({
    Key? key,
    required this.label,
    required this.description,
    required this.values,
    required this.value,
    required this.nullable,
    required this.enabled,
  }) : super(key: key);

  final String label;
  final String? description;
  final List<Option<T>> values;
  final T value;
  final bool enabled;
  final bool nullable;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final description = this.description;

    return KnobListTile(
      nullable: nullable,
      enabled: enabled,
      onToggled: (enabled) => context
          .read<KnobsNotifier>()
          .update<T?>(label, enabled ? value : null),
      isThreeLine: description != null,
      title: DropdownButtonFormField<Option<T>>(
        decoration: InputDecoration(
          isDense: true,
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        isExpanded: true,
        value: values.firstWhereOrNull((e) => e.value == value),
        selectedItemBuilder: (context) => [
          for (final option in values) Text(option.label),
        ],
        items: [
          for (final option in values)
            DropdownMenuItem<Option<T>>(
              value: option,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(option.label),
                  if (option.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      // ignore: avoid-non-null-assertion, checked for null
                      option.description!,
                      style: textTheme.bodyText2?.copyWith(
                        color: textTheme.caption?.color,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
        onChanged: (v) {
          if (v != null) {
            context.read<KnobsNotifier>().update<T>(label, v.value);
          }
        },
      ),
      subtitle: description == null
          ? null
          : Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(description),
            ),
    );
  }
}
