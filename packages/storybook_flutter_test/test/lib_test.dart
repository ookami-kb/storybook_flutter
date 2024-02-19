import 'package:flutter/material.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_test/storybook_flutter_test.dart';

void main() => testStorybook(
      storybook,
      layouts: [
        (
          device: Devices.ios.iPhone13,
          orientation: Orientation.portrait,
          isFrameVisible: false,
        ),
        (
          device: Devices.ios.iPadPro11Inches,
          orientation: Orientation.landscape,
          isFrameVisible: true,
        ),
        (
          device: Devices.android.samsungGalaxyA50,
          orientation: Orientation.portrait,
          isFrameVisible: true,
        ),
      ],
    );

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
