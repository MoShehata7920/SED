import 'dart:async';
import 'dart:ui';
import 'package:sed/presentation/base/baseviewmodel.dart';

class AddAdvertisementViewModel extends BaseViewModel
    with AddAdvertisementViewModelInputs, AddAdvertisementViewModelOutputs {
  final StreamController _imageValidationStreamController =
      StreamController<String>.broadcast();

  final StreamController _nameValidationStreamController =
      StreamController<String>.broadcast();

  final StreamController _priceValidationStreamController =
      StreamController<String>.broadcast();

  final StreamController _descriptionValidationStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllValidationStreamController =
      StreamController<void>.broadcast();

  // inputs
  @override
  void start() {}

  @override
  void dispose() {
    _imageValidationStreamController.close();
    _nameValidationStreamController.close();
    _priceValidationStreamController.close();
    _descriptionValidationStreamController.close();
    _areAllValidationStreamController.close();

    super.dispose();
  }

  @override
  Sink get imageInput => _imageValidationStreamController.sink;

  @override
  Sink get nameInput => _nameValidationStreamController.sink;

  @override
  Sink get priceInput => _priceValidationStreamController.sink;

  @override
  Sink get descriptionInput => _descriptionValidationStreamController.sink;

  @override
  Sink get areAllInputsValidInput => _areAllValidationStreamController.sink;

  // outputs
  @override
  Stream<bool> get isImageValidOutput => _imageValidationStreamController.stream
      .map((image) => _isImageValid(image));

  @override
  Stream<bool> get isNameValidOutput =>
      _nameValidationStreamController.stream.map((name) => _isNameValid(name));

  @override
  Stream<bool> get isPriceValidOutput => _priceValidationStreamController.stream
      .map((price) => _isPriceValid(price));

  @override
  Stream<bool> get isDescriptionValidOutput =>
      _descriptionValidationStreamController.stream
          .map((description) => _isDescriptionValid(description));

  @override
  Stream<bool> get areAllInputsValidOutput =>
      _areAllValidationStreamController.stream.map((_) => _areAllInputsValid());

  // private functions
  bool _isImageValid(String image) {
    return image.isNotEmpty;
  }

  bool _isNameValid(String name) {
    return name.isNotEmpty;
  }

  bool _isPriceValid(String price) {
    return price.isNotEmpty;
  }

  bool _isDescriptionValid(String description) {
    return description.isNotEmpty;
  }

  bool _areAllInputsValid() {
    return _isImageValid(image) &&
        _isNameValid() &&
        _isPriceValid() &&
        _isDescriptionValid();
  }
}

abstract class AddAdvertisementViewModelInputs {
  Sink get imageInput;
  Sink get nameInput;
  Sink get priceInput;
  Sink get descriptionInput;

  Sink get areAllInputsValidInput;
}

abstract class AddAdvertisementViewModelOutputs {
  Stream<bool> get isImageValidOutput;
  Stream<bool> get isNameValidOutput;
  Stream<bool> get isPriceValidOutput;
  Stream<bool> get isDescriptionValidOutput;

  Stream<bool> get areAllInputsValidOutput;
}
