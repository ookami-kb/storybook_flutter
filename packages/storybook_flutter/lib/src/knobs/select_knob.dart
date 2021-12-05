import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../plugins/knobs.dart';
import 'knobs.dart';

class SelectKnob<T> extends Knob<T> {
  SelectKnob(String label, T value, this.options) : super(label, value);

  final List<Option<T>> options;

  @override
  Widget build() => SelectKnobWidget<T>(
        label: label,
        value: value,
        values: options,
      );
}

/// Option for select knob.
class Option<T> {
  const Option(this.text, this.value);

  final String text;
  final T value;
}

class SelectKnobWidget<T> extends StatelessWidget {
  const SelectKnobWidget({
    Key? key,
    required this.label,
    required this.values,
    required this.value,
  }) : super(key: key);

  final String label;
  final List<Option<T>> values;
  final T value;

  @override
  Widget build(BuildContext context) => ListTile(
        title: DropdownButtonFormField<Option<T>>(
          decoration: InputDecoration(
            isDense: true,
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          isExpanded: true,
          value: values.firstWhereOrNull((e) => e.value == value),
          items: values
              .map((e) => DropdownMenuItem<Option<T>>(
                    value: e,
                    child: Text(e.text),
                  ))
              .toList(),
          onChanged: (v) {
            if (v != null) {
              context.read<KnobsNotifier>().update<T>(label, v.value);
            }
          },
        ),
      );
}
