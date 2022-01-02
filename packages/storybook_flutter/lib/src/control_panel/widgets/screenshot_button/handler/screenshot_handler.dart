import './screenshot_handler_unsupported.dart'
    if (dart.library.html) './screenshot_handler_web.dart'
    if (dart.library.io) './screenshot_handler_io.dart';

import '../screenshot_entity.dart';

abstract class ScreenShotHandlerInterface {
  Future<void> saveImage(ScreenShot screenShot);
}

class ScreenShotHandler implements ScreenShotHandlerInterface {
  @override
  Future<void> saveImage(ScreenShot screenShot) =>
      ScreenShotHandlerImpl().saveImage(screenShot);
}
