import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

enum ReportImageSource { camera, gallery }

abstract interface class ImagePickerService {
  Future<XFile?> pickImage(ReportImageSource source);
}

class ImagePickerServiceImpl implements ImagePickerService {
  ImagePickerServiceImpl({ImagePicker? picker})
    : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  @override
  Future<XFile?> pickImage(ReportImageSource source) {
    return _picker.pickImage(
      source: source == ReportImageSource.camera
          ? ImageSource.camera
          : ImageSource.gallery,
      imageQuality: 80,
      maxWidth: 1600,
    );
  }
}

final imagePickerServiceProvider = Provider<ImagePickerService>((ref) {
  return ImagePickerServiceImpl();
});
