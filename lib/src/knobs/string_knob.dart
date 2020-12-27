import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/knobs/utils.dart';

class StringKnob extends Knob<String> {
  StringKnob(String label, String value) : super(label, value);

  @override
  Widget build() => StringKnobWidget(label: label, value: value);
}

class StringKnobWidget extends StatelessWidget {
  const StringKnobWidget({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) => ListTile(
        title: TextFormField(
          decoration: InputDecoration(labelText: label),
          initialValue: value,
          onChanged: (v) => context.knobs.update(label, v),
        ),
      );
}
