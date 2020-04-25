import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

class SelectKnob<T> extends Knob<T> {
  SelectKnob(String label, T value, this.options) : super(label, value);

  final List<Select<T>> options;

  @override
  Widget build() => SelectKnobWidget<T>(
        label: label,
        value: value,
        values: options,
      );
}

class Select<T> {
  const Select(this.text, this.value);

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
  final List<Select<T>> values;
  final T value;

  @override
  Widget build(BuildContext context) => Consumer<Knobs>(
        builder: (context, knobs, _) => ListTile(
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
            onChanged: (v) => knobs.update(label, v),
          ),
        ),
      );
}
