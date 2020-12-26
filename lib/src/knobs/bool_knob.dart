import 'package:flutter/material.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';
import 'package:storybook_flutter/src/knobs/utils.dart';

class BoolKnob extends Knob<bool> {
  BoolKnob(String label, bool value) : super(label, value);

  @override
  Widget build() => BooleanKnobWidget(label: label, value: value);
}

class BooleanKnobWidget extends StatelessWidget {
  const BooleanKnobWidget({Key? key, required this.label, required this.value})
      : super(key: key);

  final String label;
  final bool value;

  @override
  Widget build(BuildContext context) => CheckboxListTile(
        title: Text(label),
        value: value,
        onChanged: (v) => context.knobs.update(label, v),
      );
}
