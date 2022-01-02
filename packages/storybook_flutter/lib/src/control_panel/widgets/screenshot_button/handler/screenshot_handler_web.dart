import 'dart:convert';
import 'dart:html' as html;

import 'package:storybook_flutter/src/control_panel/widgets/screenshot_button/handler/screenshot_handler.dart';
import 'package:storybook_flutter/src/control_panel/widgets/screenshot_button/screenshot_entity.dart';


class ScreenShotHandlerImpl implements ScreenShotHandlerInterface {
  @override
  Future<void> saveImage(ScreenShot screenShot) async {
    final base64data = base64Encode(screenShot.image);
    html.AnchorElement(href: 'data:image/jpeg;base64,$base64data')
      ..download = '${screenShot.filename}.png'
      ..click()
      ..remove();
  }
}
