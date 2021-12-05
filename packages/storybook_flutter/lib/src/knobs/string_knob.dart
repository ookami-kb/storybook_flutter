import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../plugins/knobs.dart';
import 'knobs.dart';

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
          decoration: InputDecoration(
            isDense: true,
            labelText: label,
            border: const OutlineInputBorder(),
          ),
          initialValue: value,
          onChanged: (v) => context.read<KnobsNotifier>().update(label, v),
        ),
      );
}
