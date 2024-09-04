import 'package:farmerapp/helper/phone_image.dart';
import 'image_picker_interface.dart';

ImagePickerInterface createImagePicker() {
  return PhoneImagePicker();
}
