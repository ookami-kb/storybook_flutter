import 'dart:typed_data';

class ScreenShot {
  const ScreenShot(this.image, this.filename);

  final Uint8List image;
  final String filename;
}