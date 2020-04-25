import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Storybook(
        children: [
          Story(
            name: 'Flat button',
            builder: (_, k) => MaterialButton(
              child: Text(k.text('Text', initial: 'Flat button')),
              onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
            ),
          ),
          Story(
            name: 'Raised button',
            builder: (_, k) => RaisedButton(
              child: Text(k.text('Text', initial: 'Raised button')),
              onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
            ),
          ),
          Story.simple(
            name: 'Input field',
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input field',
              ),
            ),
          ),
        ],
      );
}
