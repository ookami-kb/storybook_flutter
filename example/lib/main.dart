import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Storybook(
        children: [
          Story(
            name: 'Flat button',
            child: MaterialButton(child: Text('Flat button'), onPressed: () {}),
          ),
          Story(
            name: 'Raised button',
            child: RaisedButton(child: Text('Raised button'), onPressed: () {}),
          ),
          Story(
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
