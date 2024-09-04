import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:farmerapp/helper/image_picker_interface.dart';

class PhoneImagePicker implements ImagePickerInterface {
  final picker = ImagePicker();

  @override
  Future<Uint8List?> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return await pickedFile.readAsBytes();  // Reading bytes asynchronously
    }
    return null;
  }
}
