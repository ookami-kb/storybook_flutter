import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:storybook_flutter/src/control_panel/widgets/screenshot_button/handler/screenshot_handler.dart';
import 'package:storybook_flutter/src/control_panel/widgets/screenshot_button/screenshot_entity.dart';

class ScreenShotHandlerImpl implements ScreenShotHandlerInterface {
  @override
  Future<void> saveImage(ScreenShot screenShot) async {
    final file = await File(
            '${await _directoryPath}/screenshots/${screenShot.filename}.png')
        .create(recursive: true);
    await file.writeAsBytes(screenShot.image);
  }

  Future<String> get _directoryPath async {
    if (Platform.isAndroid) {
      return (await getExternalStorageDirectory())!.path;
    }
    return (await getApplicationDocumentsDirectory()).path;
  }
}
