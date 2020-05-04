import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/knobs/utils.dart';

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
    Key key,
    this.label,
    this.values,
    this.value,
  }) : super(key: key);

  final String label;
  final List<Option<T>> values;
  final T value;

  @override
  Widget build(BuildContext context) => ListTile(
        title: DropdownButtonFormField<T>(
          decoration: InputDecoration(labelText: label),
          isExpanded: true,
          value: value,
          items: values
              .map(
                (e) => DropdownMenuItem<T>(
                  value: e.value,
                  child: Text(e.text),
                ),
              )
              .toList(),
          onChanged: (v) => context.knobs.update(label, v),
        ),
      );
}
