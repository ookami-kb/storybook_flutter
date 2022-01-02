import './screenshot_handler_unsupported.dart';
import '../screenshot_entity.dart';

abstract class ScreenShotHandlerInterface {
  Future<void> saveImage(ScreenShot screenShot);
}

class ScreenShotHandler implements ScreenShotHandlerInterface {
  @override
  Future<void> saveImage(ScreenShot screenShot) =>
      ScreenShotHandlerImpl().saveImage(screenShot);
}
