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
              onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
              child: Text(k.text('Text', initial: 'Flat button')),
            ),
          ),
          Story(
            name: 'Raised button',
            builder: (_, k) => RaisedButton(
              onPressed: k.boolean('Enabled', initial: true) ? () {} : null,
              color: k.options(
                'Color',
                initial: Colors.deepOrange,
                options: const [
                  Option('Red', Colors.deepOrange),
                  Option('Green', Colors.teal),
                ],
              ),
              textColor: Colors.white,
              child: Text(k.text('Text', initial: 'Raised button')),
            ),
          ),
          Story.simple(
            name: 'Input field',
            child: const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input field',
              ),
            ),
          ),
        ],
      );
}
