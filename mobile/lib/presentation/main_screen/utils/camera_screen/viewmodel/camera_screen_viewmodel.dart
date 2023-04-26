import 'dart:async';
import 'package:image_picker/image_picker.dart';

class CameraScreenViewModel {
  final ImagePicker _imagePicker = ImagePicker();

  final StreamController<XFile> _imageStreamController =
      StreamController<XFile>.broadcast();

  Stream<XFile> get imageStream => _imageStreamController.stream;

  Future<void> getImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageStreamController.add(pickedFile);
    }
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageStreamController.add(pickedFile);
    }
  }

  void dispose() {
    _imageStreamController.close();
  }
}
