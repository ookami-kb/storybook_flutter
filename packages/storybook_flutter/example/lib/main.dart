import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Storybook(
        plugins: [
          DeviceFramePlugin(
            initialData: DeviceFrameData(device: Devices.macos.iMacPro),
          )
        ],
        storyWrapperBuilder: (_, story, child) => Stack(
          children: [
            Container(
              padding: story.padding,
              color: Theme.of(context).canvasColor,
              child: Center(child: child),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topRight,
                child: Text(
                  story.name,
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),
          ],
        ),
        children: [
          Story(
            section: 'Button',
            name: 'Flat button',
            builder: (_, k) => MaterialButton(
              onPressed:
                  k.boolean(label: 'Enabled', initial: true) ? () {} : null,
              child: Text(k.text(label: 'Text', initial: 'Flat button')),
            ),
          ),
          Story(
            section: 'Button',
            name: 'Raised button',
            // ignore: deprecated_member_use
            builder: (_, k) => RaisedButton(
              onPressed:
                  k.boolean(label: 'Enabled', initial: true) ? () {} : null,
              color: k.options(
                label: 'Color',
                initial: Colors.deepOrange,
                options: const [
                  Option('Red', Colors.deepOrange),
                  Option('Green', Colors.teal),
                ],
              ),
              mouseCursor: k.options(
                label: 'Mouse Cursor',
                initial: null,
                options: const [
                  Option('Basic', SystemMouseCursors.basic),
                  Option('Click', SystemMouseCursors.click),
                  Option('Forbidden', SystemMouseCursors.forbidden),
                ],
              ),
              elevation: k.slider(label: 'Elevation', initial: 0, max: 20),
              textColor: Colors.white,
              child: Text(k.text(label: 'Text', initial: 'Raised button')),
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

class FramePlugin extends Plugin<bool> {
  FramePlugin()
      : super(
          storyBuilder: _storyBuilder,
          icon: Icons.crop_square,
          settingsBuilder: _settingsBuilder,
        );
}

Widget _storyBuilder(
  BuildContext context,
  Story story,
  Widget child,
  bool? data,
) =>
    data != false ? _frame(child) : child;

Widget _frame(Widget child) => Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 8),
        borderRadius: BorderRadius.circular(4),
      ),
      child: child,
    );

Widget _settingsBuilder(
  BuildContext context,
  Story? story,
  bool? data,
  void Function(bool?) update,
) =>
    CheckboxListTile(
      title: const Text('Show frame'),
      value: data ?? true,
      onChanged: update,
    );
