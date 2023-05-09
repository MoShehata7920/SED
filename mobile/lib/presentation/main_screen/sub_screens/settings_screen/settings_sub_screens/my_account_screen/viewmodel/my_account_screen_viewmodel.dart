import 'dart:async';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import '../../../../../../../app/di.dart';
import '../../../../../../../domain/usecase/myprofile_data_usecase.dart';
import '../../../../../../../domain/usecase/update_profile_usecase.dart';
import '../../../../../../common/freezed_data_classes.dart';
import '../../../../../../resources/strings_manager.dart';

class MyAccountViewModel extends BaseViewModel
    with MyAccountViewModelInputs, MyAccountViewModelOutputs {
  final MyProfileDataUseCase _myProfileDataUseCase =
      instance<MyProfileDataUseCase>();

  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  final StreamController _phoneNumberStreamController =
      StreamController<String>.broadcast();

  final StreamController _governmentStreamController =
      StreamController<String>.broadcast();

  final StreamController _addressStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  GetMyProfileData? userData;

  var userProfileObject = UserProfileObject(null, null, null, null, null);

  final UpdateProfileUseCase _updateProfileUseCase =
      instance<UpdateProfileUseCase>();

  @override
  Future start() async {
    await getUserData();
  }

  // Inputs
  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Sink get inputPhoneNumber => _phoneNumberStreamController.sink;

  @override
  Sink get inputGovernment => _governmentStreamController.sink;

  @override
  Sink get inputAddress => _addressStreamController.sink;

  @override
  Sink get inputAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  void setUserImage(XFile? userImage) {
    if (userImage != null) {
      userProfileObject =
          userProfileObject.copyWith(userImage: File(userImage.path));
    }
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);

    if (_isUserNameValid(userName)) {
      userProfileObject = userProfileObject.copyWith(userName: userName);
    } else {
      userProfileObject = userProfileObject.copyWith(userName: "");
    }

    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputPhoneNumber.add(mobileNumber);

    if (_isMobileNumberValid(mobileNumber)) {
      userProfileObject = userProfileObject.copyWith(userPhone: mobileNumber);
    } else {
      userProfileObject = userProfileObject.copyWith(userPhone: "");
    }

    validate();
  }

  @override
  setUserGovernment(String uerGovernment) {
    inputGovernment.add(uerGovernment);

    if (_isGovernmentValid(uerGovernment)) {
      userProfileObject = userProfileObject.copyWith(government: uerGovernment);
    } else {
      userProfileObject = userProfileObject.copyWith(government: "");
    }

    validate();
  }

  @override
  setAddress(String userAddress) {
    inputAddress.add(userAddress);

    if (_isAddressValid(userAddress)) {
      userProfileObject = userProfileObject.copyWith(address: userAddress);
    } else {
      userProfileObject = userProfileObject.copyWith(address: "");
    }

    validate();
  }

  // Outputs
  @override
  // TODO: implement imageOutput
  Stream<String> get imageOutput => throw UnimplementedError();

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserNameValid =>
      outputIsUserNameValid.map((isUserNameValid) =>
          isUserNameValid ? null : AppStrings.userNameInValid);

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _phoneNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumberValid =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.mobileNumberInValid);

  @override
  Stream<bool> get outputIsUserGovernmentValid =>
      _governmentStreamController.stream
          .map((government) => _isGovernmentValid(government));

  @override
  Stream<bool> get outputIsAddressValid => _addressStreamController.stream
      .map((address) => _isAddressValid(address));

  @override
  Stream<String?> get outputErrorAddressValid => outputIsAddressValid.map(
      (isAddressValid) => isAddressValid ? null : AppStrings.addressError);

  @override
  // TODO: implement outputAreAllInputsValid
  Stream<bool> get outputAreAllInputsValid => throw UnimplementedError();

  // private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 6;
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 9;
  }

  bool _isGovernmentValid(String userGovernment) {
    return userGovernment.isNotEmpty;
  }

  bool _isAddressValid(String userAddress) {
    return userAddress.isNotEmpty;
  }

  bool _areAllInputsValid() {
    // TODO: implement _areAllInputsValid
    throw UnimplementedError();
  }

  validate() {
    inputAllInputsValid.add(null);
  }

  @override
  updateUserProfile() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _updateProfileUseCase.execute(
        UpdateUserProfileUseCaseInput(
            userData!.user.id,
            userProfileObject.userImage,
            userProfileObject.userName,
            userProfileObject.userPhone,
            userProfileObject.government,
            userProfileObject.address));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenLoadingState, failure.message))
            }, (response) {
      // right -> success

      inputState.add(SuccessState(
          StateRendererType.popUpSuccessState, "Success", AppStrings.success.tr(),(){}));
    });
  }

  Future getUserData() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _myProfileDataUseCase.execute(Constants.token);

    response.fold(
        (failure) => {
              // left -> failure

              inputState.add(ErrorState(
                  StateRendererType.fullScreenLoadingState, failure.message))
            }, (response) {
      // right -> success
      userData = response;

      inputState.add(ContentState());
    });
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _phoneNumberStreamController.close();
    _governmentStreamController.close();
    _addressStreamController.close();

    _areAllInputsValidStreamController.close();
  }
}

abstract class MyAccountViewModelInputs {
  Sink get inputUserName;

  Sink get inputPhoneNumber;

  Sink get inputGovernment;

  Sink get inputAddress;

  Sink get inputAllInputsValid;

  updateUserProfile();

  void setUserImage(XFile? userImage);

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setUserGovernment(String uerGovernment);

  setAddress(String userAddress);
}

abstract class MyAccountViewModelOutputs {
  Stream<String> get imageOutput;

  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserNameValid;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumberValid;

  Stream<bool> get outputIsUserGovernmentValid;

  Stream<bool> get outputIsAddressValid;

  Stream<String?> get outputErrorAddressValid;

  Stream<bool> get outputAreAllInputsValid;
}
