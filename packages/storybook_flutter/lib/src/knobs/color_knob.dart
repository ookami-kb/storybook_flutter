import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knob_list_tile.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/plugins/knobs.dart';

class ColorKnobValue<T> extends KnobValue<T> {
  ColorKnobValue({
    required T value,
    required this.options,
  }) : super(
          value: value,
        );
  final List<Option<T>> options;

  @override
  Widget build({
    required String label,
    required String? description,
    required bool enabled,
    required bool nullable,
  }) =>
      ColorKnobWidget<T>(
        label: label,
        description: description,
        value: value,
        values: options,
        enabled: enabled,
        nullable: nullable,
      );
}

class ColorKnobWidget<T> extends StatelessWidget {
  const ColorKnobWidget({
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
                  Row(
                    children: [
                      Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: parseColor(option.value),
                            borderRadius: BorderRadius.circular(25),
                          )),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        option.label,
                      ),
                    ],
                  ),
                  if (option.description != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      // ignore: avoid-non-null-assertion, checked for null
                      option.description!,
                      style: textTheme.bodyMedium?.copyWith(
                        color: textTheme.bodySmall?.color,
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

  // Safety mechanism
  Color parseColor(T value) {
    Color color;
    try {
      color = value as Color;
      return color;
    } catch (e) {
      return Colors.black;
    }
  }
}
