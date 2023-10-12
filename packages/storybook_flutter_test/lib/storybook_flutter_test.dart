import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:storybook_flutter/storybook_flutter.dart';
import 'package:storybook_flutter_test/src/font_loader.dart';

typedef Layout = ({
  DeviceInfo device,
  Orientation orientation,
  bool isFrameVisible,
});

@isTest
Future<void> testStorybook(
  Storybook storybook, {
  List<Layout>? layouts,
  bool Function(Story story)? filterStories,
  FutureOr<void> Function(WidgetTester tester, Story story)? pump,
}) async {
  await loadAppFonts();

  for (final story
      in storybook.stories.where((s) => filterStories?.call(s) ?? true)) {
    _testStory(
      storybook,
      story.name,
      layouts: layouts,
      pump: (tester) => pump?.call(tester, story),
    );
  }
}

@isTest
void _testStory(
  Storybook storybook,
  String story, {
  List<Layout>? layouts,
  required FutureOr<void> Function(WidgetTester tester) pump,
}) {
  final Layout defaultLayout = (
    device: Devices.ios.iPhone13,
    orientation: Orientation.portrait,
    isFrameVisible: false,
  );
  for (final info in layouts ?? [defaultLayout]) {
    testWidgets(story, tags: ['golden', 'storybook'], (tester) async {
      debugDisableShadows = false;
      final (:device, :orientation, :isFrameVisible) = info;
      final size = (isFrameVisible ? device.frameSize : device.screenSize) *
          device.pixelRatio;

      tester.view
        ..padding = FakeViewPadding.zero
        ..viewInsets = FakeViewPadding.zero
        ..viewPadding = FakeViewPadding.zero
        ..physicalSize = switch (orientation) {
          Orientation.portrait => size,
          Orientation.landscape => size.flipped,
        };

      await tester.pumpWidget(
        Directionality(
          textDirection: TextDirection.ltr,
          child: DeviceFrame(
            device: device,
            isFrameVisible: isFrameVisible,
            orientation: orientation,
            screen: Storybook(
              initialStory: story,
              showPanel: false,
              wrapperBuilder: storybook.wrapperBuilder,
              stories: storybook.stories,
            ),
          ),
        ),
      );

      await pump(tester);

      await expectLater(
        find.byType(Storybook),
        matchesGoldenFile(
          'storybook_goldens/$story/${device.name.replaceAll('"', '')}.png',
        ),
      );

      debugDisableShadows = true;
    });
  }
}
