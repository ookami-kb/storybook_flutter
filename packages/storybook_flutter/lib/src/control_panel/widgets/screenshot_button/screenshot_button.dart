import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:storybook_flutter/src/control_panel/widgets/screenshot_button/screenshot_entity.dart';
import 'package:storybook_flutter/src/story_provider.dart';

import 'handler/screenshot_handler.dart';

class ScreenShotButton extends StatelessWidget {
  const ScreenShotButton({Key? key}) : super(key: key);

  Future<void> _print(BuildContext context) async {
    final image = await _captureStoryAsImage(context);
    if (image == null) return;
    return ScreenShotHandler().saveImage(image);
  }

  Future<ScreenShot?> _captureStoryAsImage(BuildContext context) async {
    final story = context.read<StoryProvider>().currentStory;
    if (story == null) return null;

    final boundary = story.screenShotKey.currentContext!.findRenderObject()
        as RenderRepaintBoundary;
    final image = await boundary.toImage(
        pixelRatio: MediaQuery.of(context).devicePixelRatio);
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    if (byteData == null) return null;
    return ScreenShot(byteData.buffer.asUint8List(), story.name);
  }

  @override
  Widget build(BuildContext context) => IconButton(
        onPressed: () => _print(context),
        icon: const Icon(Icons.fit_screen_outlined),
      );
}
