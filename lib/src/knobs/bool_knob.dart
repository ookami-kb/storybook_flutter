import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knob_panel.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

class BoolKnob extends Knob<bool> {
  BoolKnob(String label, bool value) : super(label, value);

  @override
  Widget build() => BooleanKnobWidget(label: label);
}

class BooleanKnobWidget extends StatelessWidget {
  const BooleanKnobWidget({Key key, this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) => Consumer<Knobs>(
        builder: (context, knobs, _) => CheckboxListTile(
          title: Text(label),
          value: knobs.get(label),
          onChanged: (v) => knobs.update(label, v),
        ),
      );
}
