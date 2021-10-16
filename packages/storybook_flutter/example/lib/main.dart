import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        initialStory: 'name',
        stories: [
          Story(
            name: 'name',
            builder: (context) => TextButton(
              onPressed: () => showDialog<void>(
                context: context,
                builder: (context) => const AlertDialog(
                  title: Text('Hello'),
                  content: Text('Hello World!'),
                ),
              ),
              child: const Text('Press me'),
            ),
          ),
        ],
      );
}
