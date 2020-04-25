import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/knobs/knobs.dart';

class KnobPanel extends StatelessWidget {
  const KnobPanel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer<Knobs>(
        builder: (context, knobs, _) => knobs.all().isEmpty
            ? Container()
            : Container(
                color: Theme.of(context).canvasColor,
                width: 200,
                child: ListView(
                  children: knobs
                      .all()
                      .map((v) => _typeMapper[v.value.runtimeType](v.key))
                      .toList(),
                ),
              ),
      );
}

final _typeMapper = <Type, Widget Function(String)>{
  bool: (String label) => BooleanKnobWidget(label: label),
  String: (String label) => StringKnobWidget(label: label),
};

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
