import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CameraScreenViewModel {
  final ImagePicker _imagePicker = ImagePicker();

  final StreamController<File> _imageStreamController =
      StreamController<File>.broadcast();

  Stream<File> get imageStream => _imageStreamController.stream;

  Future<void> getImageFromCamera() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageStreamController.add(File(pickedFile.path));
    }
  }

  Future<void> getImageFromGallery() async {
    final pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _imageStreamController.add(File(pickedFile.path));
    }
  }

  void dispose() {
    _imageStreamController.close();
  }
}
