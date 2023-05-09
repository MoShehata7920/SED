import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/usecase/add_advertisement_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/freezed_data_classes.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'dart:convert';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../../domain/usecase/update_ad_usecase.dart';

class AddAdvertisementViewModel extends BaseViewModel
    with AddAdvertisementViewModelInputs, AddAdvertisementViewModelOutputs {
  AdvertisementObject advertisementObject =
      AdvertisementObject(File(""), "", 0, "", "", "", "");

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

  final AddAdvertisementUseCase _addAdvertisementUseCase =
      instance<AddAdvertisementUseCase>();

  final UpdateAdUseCase _updateAdUseCase = instance<UpdateAdUseCase>();

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
  Stream<String> get imageOutput =>
      _imageValidationStreamController.stream.map((image) => image);

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
        _isDescriptionValid(advertisementObject.description) &&
        _isImageValid(advertisementObject.image == null ? "" : "image");
  }

  @override
  void setDescription(String description) {
    descriptionInput.add(description);
    advertisementObject =
        advertisementObject.copyWith(description: description);
    areAllInputsValidInput.add(null);
  }

  @override
  void setConditions(String purpose, String category, String condition) {
    advertisementObject = advertisementObject.copyWith(
        purpose: purpose, category: category, condition: condition);
  }

  @override
  void setImage(image) {
    XFile imageMapping = image ?? XFile("");

    File imageFile = File(imageMapping.path);

    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64.encode(imageBytes);
    advertisementObject = advertisementObject.copyWith(image: imageFile);

    areAllInputsValidInput.add(null);
    imageInput.add(imageMapping.path);
  }

  @override
  void setName(String name) {
    nameInput.add(name);
    advertisementObject = advertisementObject.copyWith(name: name);
    areAllInputsValidInput.add(null);
  }

  @override
  void setPrice(int price) {
    priceInput.add(price);
    advertisementObject = advertisementObject.copyWith(price: price);
    areAllInputsValidInput.add(null);
  }

  @override
  void addAdvertisement(BuildContext context) async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _addAdvertisementUseCase
        .execute(AddAdvertisementUseCaseUseCaseInput(
      advertisementObject.image,
      advertisementObject.name,
      advertisementObject.price,
      advertisementObject.description,
      advertisementObject.purpose,
      advertisementObject.category,
      advertisementObject.condition,
      Constants.token,
    ));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popUpErrorState, failure.message))
            }, (response) {
      // right -> success
      inputState.add(SuccessState(
          StateRendererType.popUpSuccessState,
          AppStrings.successfullyAddedAd,
          AppStrings.success.tr(),
          () => Navigator.of(context)
              .pushReplacementNamed(Routes.mainScreenRoute)));
    });
  }

  void updateAd(BuildContext context, String itemId) async {

    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _updateAdUseCase.execute(UpdateAdUseCaseInput(
      itemId,
      advertisementObject.image,
      advertisementObject.name,
      advertisementObject.price,
      advertisementObject.description,
      advertisementObject.purpose,
      advertisementObject.category,
      advertisementObject.condition,
      Constants.token,
    ));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popUpErrorState, failure.message))
            }, (response) {
      // right -> success
      inputState.add(SuccessState(
          StateRendererType.popUpSuccessState,
          AppStrings.successfullyUpdatedAd,
          AppStrings.success.tr(),
          () => Navigator.of(context)
              .pushReplacementNamed(Routes.mainScreenRoute)));
    });
  }
}

abstract class AddAdvertisementViewModelInputs {
  Sink get nameInput;

  Sink get priceInput;

  Sink get descriptionInput;

  Sink get areAllInputsValidInput;

  Sink get imageInput;

  void setImage(XFile? image);

  void setName(String name);

  void setPrice(int price);

  void setDescription(String description);

  void setConditions(String purpose, String category, String condition);

  void addAdvertisement(BuildContext context);
}

abstract class AddAdvertisementViewModelOutputs {
  Stream<String> get imageOutput;

  Stream<bool> get isNameValidOutput;

  Stream<bool> get isPriceValidOutput;

  Stream<bool> get isDescriptionValidOutput;

  Stream<bool> get areAllInputsValidOutput;
}
