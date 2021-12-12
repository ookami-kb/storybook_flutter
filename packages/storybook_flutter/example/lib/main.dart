import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

final _plugins = initializePlugins(
  contentsSidePanel: true,
  knobsSidePanel: true,
  initialDeviceFrameData: DeviceFrameData(
    device: Devices.ios.iPhone13,
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        initialStory: 'Scaffold',
        plugins: _plugins,
        stories: [
          Story(
            name: 'Button',
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
          Story(
            name: 'Text',
            builder: (context) => Text(
              context.knobs.text(label: 'Text', initial: 'Simple text story'),
            ),
          ),
          Story(
            name: 'Scaffold',
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Storybook'),
              ),
              body: const Center(child: Text('Hello World!')),
            ),
          ),
          Story(
            name: 'Counter',
            builder: (context) => CounterPage(
              title: context.knobs.text(label: 'Title', initial: 'Counter'),
              enabled: context.knobs.boolean(label: 'Enabled', initial: true),
            ),
          ),
        ],
      );
}

class CounterPage extends StatefulWidget {
  const CounterPage({
    Key? key,
    required this.title,
    this.enabled = true,
  }) : super(key: key);

  final String title;
  final bool enabled;

  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() => setState(() => _counter++);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () => showAboutDialog(
                context: context,
                applicationName: 'Storybook',
                applicationVersion: '0.0.1',
                applicationIcon: const Icon(Icons.book),
                applicationLegalese: 'MIT License',
              ),
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('You have pushed the button this many times:'),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        floatingActionButton: widget.enabled
            ? FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              )
            : null,
      );
}
