import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

final _plugins = initializePlugins(
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
          )
        ],
      );
}
