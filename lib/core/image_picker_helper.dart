// lib/utils/image_picker_helper.dart

import 'package:image_picker/image_picker.dart';

class ImagePickerHelper {
  static final ImagePicker _picker = ImagePicker();

  // 갤러리에서 이미지 선택
  static Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      return image;
    } catch (e) {
      print('이미지 선택 중 오류 발생: $e');
      return null;
    }
  }

  // 카메라로 이미지 촬영
  static Future<XFile?> takeImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      return image;
    } catch (e) {
      print('카메라 사용 중 오류 발생: $e');
      return null;
    }
  }
}
