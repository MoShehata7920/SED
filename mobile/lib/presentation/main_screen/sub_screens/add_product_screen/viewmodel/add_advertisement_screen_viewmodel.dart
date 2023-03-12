import 'dart:async';
import 'dart:ui';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/freezed_data_classes.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class AddAdvertisementViewModel extends BaseViewModel
    with AddAdvertisementViewModelInputs, AddAdvertisementViewModelOutputs {
  AdvertisementObject advertisementObject =
      AdvertisementObject("", "", "", "", 0, 0, 0);

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
  void start() {
    inputState.add(ContentState());
  }

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
    return _isNameValid(advertisementObject.name) &&
        _isPriceValid(advertisementObject.price) &&
        _isDescriptionValid(advertisementObject.description);
  }

  @override
  void setDescription(String description) {
    descriptionInput.add(description);
    advertisementObject =
        advertisementObject.copyWith(description: description);
    areAllInputsValidInput.add(null);
  }

  @override
  void setIds(int sectionId, int categoryId, int conditionId) {
    advertisementObject = advertisementObject.copyWith(
        sectionId: sectionId, categoryId: categoryId, conditionId: conditionId);
  }

  @override
  void setImage(String image) {
    imageInput.add(image);
    advertisementObject = advertisementObject.copyWith(image: image);
    areAllInputsValidInput.add(null);
  }

  @override
  void setName(String name) {
    nameInput.add(name);
    advertisementObject = advertisementObject.copyWith(name: name);
    areAllInputsValidInput.add(null);
  }

  @override
  void setPrice(String price) {
    priceInput.add(price);
    advertisementObject = advertisementObject.copyWith(price: price);
    areAllInputsValidInput.add(null);
  }
}

abstract class AddAdvertisementViewModelInputs {
  Sink get imageInput;

  Sink get nameInput;

  Sink get priceInput;

  Sink get descriptionInput;

  Sink get areAllInputsValidInput;

  void setImage(String image);

  void setName(String name);

  void setPrice(String price);

  void setDescription(String description);

  void setIds(int sectionId, int categoryId, int conditionId);
}

abstract class AddAdvertisementViewModelOutputs {
  Stream<bool> get isImageValidOutput;

  Stream<bool> get isNameValidOutput;

  Stream<bool> get isPriceValidOutput;

  Stream<bool> get isDescriptionValidOutput;

  Stream<bool> get areAllInputsValidOutput;
}
