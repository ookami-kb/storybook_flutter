import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_test/storybook_flutter_test.dart';

Future<void> main() async {
  await loadAppFonts();

  testStorybook(
    storybook,
    devices: [
      Devices.ios.iPhone13,
      Devices.ios.iPad,
      Devices.android.samsungGalaxyA50,
    ],
  );
}

final storybook = Storybook(
  stories: [
    Story(
      name: 'Button',
      builder: (context) => ElevatedButton(
        onPressed: () {},
        child: const Text('Button'),
      ),
    ),
  ],
);
