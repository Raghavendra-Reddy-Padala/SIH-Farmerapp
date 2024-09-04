import 'dart:typed_data';

abstract class ImagePickerInterface {
  Future<Uint8List?> pickImage();
}
