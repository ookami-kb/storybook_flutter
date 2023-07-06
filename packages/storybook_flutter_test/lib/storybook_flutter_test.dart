import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:storybook_flutter/storybook_flutter.dart';

export 'src/font_loader.dart' show loadAppFonts;

@isTest
void testStory(
  Storybook storybook,
  String story, {
  List<DeviceInfo>? devices,
}) {
  for (final device in devices ?? [Devices.ios.iPhone13]) {
    testWidgets(story, (tester) async {
      debugDisableShadows = false;

      tester.view
        ..padding = FakeViewPadding.zero
        ..viewInsets = FakeViewPadding.zero
        ..viewPadding = FakeViewPadding.zero
        ..physicalSize = device.screenSize * device.pixelRatio;

      final widget = Storybook(
        initialStory: story,
        showPanel: false,
        wrapperBuilder: (context, widget) => DeviceFrame(
          device: device,
          isFrameVisible: false,
          screen: storybook.wrapperBuilder(context, widget),
        ),
        stories: storybook.stories,
      );
      await tester.pumpWidget(widget);

      await expectLater(
        find.byType(Storybook),
        matchesGoldenFile('goldens/$story/${device.name}.png'),
      );

      debugDisableShadows = true;
    });
  }
}

@isTest
void testStorybook(
  Storybook storybook, {
  List<DeviceInfo>? devices,
}) {
  for (final story in storybook.stories) {
    testStory(storybook, story.name, devices: devices);
  }
}
