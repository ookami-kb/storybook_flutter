import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

class StringKnob extends Knob<String> {
  StringKnob(String label, String value) : super(label, value);

  @override
  Widget build() => StringKnobWidget(label: label);
}

class StringKnobWidget extends StatelessWidget {
  const StringKnobWidget({Key key, this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) => Consumer<Knobs>(
        builder: (context, knobs, _) => ListTile(
          title: TextFormField(
            decoration: InputDecoration(labelText: label),
            initialValue: knobs.get(label),
            onChanged: (v) => knobs.update(label, v),
          ),
        ),
      );
}
