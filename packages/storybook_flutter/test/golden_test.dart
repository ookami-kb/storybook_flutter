import 'package:flutter/material.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

Widget simpleStorybook(String initialRoute) => Storybook(
      initialRoute: initialRoute,
      children: [
        Story.simple(
          name: 'Button',
          child: TextButton(
            onPressed: () {},
            child: const Text('Push me'),
          ),
        ),
        Story(
          name: 'Customizable Button',
          builder: (context, k) => TextButton(
            onPressed: () {},
            child: Text(k.text(label: 'Text', initial: 'Push me')),
          ),
        )
      ],
    );

void main() {
  testGoldens('Simple story layout', (tester) async {
    final builder = DeviceBuilder()
      ..addScenario(
        widget: simpleStorybook('/stories/button'),
        name: 'simple storybook',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'simple_story_layout');
  });

  testGoldens('Story layout', (tester) async {
    final builder = DeviceBuilder()
      ..addScenario(
        widget: simpleStorybook('/stories/customizable-button'),
        name: 'simple storybook',
      );

    await tester.pumpDeviceBuilder(builder);
    await screenMatchesGolden(tester, 'story_layout');
  });
}
