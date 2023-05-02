import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import '../../../../../../../app/di.dart';
import '../../../../../../../domain/usecase/myprofile_data_usecase.dart';

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

  final StreamController _oldPasswordStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _confirmPasswordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  GetMyProfileData? userData;

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
  Sink get inputOldPassword => _oldPasswordStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputConfirmPassword => _confirmPasswordStreamController.sink;

  @override
  Sink get inputAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  void setUserImage(XFile? userImage) {
    // TODO: implement setUserImage
  }

  @override
  setUserName(String userName) {
    // TODO: implement setUserName
    throw UnimplementedError();
  }

  @override
  setMobileNumber(String mobileNumber) {
    // TODO: implement setMobileNumber
    throw UnimplementedError();
  }

  @override
  setUserGovernment(String uerGovernment) {
    // TODO: implement setUserGovernment
    throw UnimplementedError();
  }

  @override
  setAddress(String userAddress) {
    return userAddress.isNotEmpty;
  }

  @override
  setOldPassword(String oldPassword) {
    // TODO: implement setOldPassword
    throw UnimplementedError();
  }

  @override
  setPassword(String password) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setConfirmPassword(String confirmPassword) {
    // TODO: implement setConfirmPassword
    throw UnimplementedError();
  }

  @override
  updateUserProfile() {
    // TODO: implement updateUserProfile
    throw UnimplementedError();
  }

  // Outputs
  @override
  // TODO: implement imageOutput
  Stream<String> get imageOutput => throw UnimplementedError();

  @override
  // TODO: implement outputIsUserNameValid
  Stream<bool> get outputIsUserNameValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorUserNameValid
  Stream<String?> get outputErrorUserNameValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsMobileNumberValid
  Stream<bool> get outputIsMobileNumberValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorMobileNumberValid
  Stream<String?> get outputErrorMobileNumberValid =>
      throw UnimplementedError();

  @override
  // TODO: implement outputIsUserGovernmentValid
  Stream<bool> get outputIsUserGovernmentValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsAddressValid
  Stream<bool> get outputIsAddressValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorAddressValid
  Stream<String?> get outputErrorAddressValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsOldPasswordValid
  Stream<bool> get outputIsOldPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorOldPasswordValid
  Stream<String?> get outputErrorOldPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsPasswordValid
  Stream<bool> get outputIsPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorPasswordValid
  Stream<String?> get outputErrorPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputIsConfirmPasswordValid
  Stream<bool> get outputIsConfirmPasswordValid => throw UnimplementedError();

  @override
  // TODO: implement outputErrorConfirmPasswordValid
  Stream<String?> get outputErrorConfirmPasswordValid =>
      throw UnimplementedError();

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

  bool _isAddressValid(String userAddress) {
    return userAddress.isNotEmpty;
  }

  bool _isOldPasswordValid(String oldPassword) {
    return oldPassword.isPasswordValid();
  }

  bool _isPasswordValid(String password) {
    return password.isPasswordValid();
  }

  bool _isConfirmPasswordValid(String confirmPassword) {
    // TODO: implement _isConfirmPasswordValid
    throw UnimplementedError();
  }

  bool _areAllInputsValid() {
    // TODO: implement _areAllInputsValid
    throw UnimplementedError();
  }

  validate() {
    inputAllInputsValid.add(null);
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
    _oldPasswordStreamController.close();
    _passwordStreamController.close();
    _confirmPasswordStreamController.close();
    _areAllInputsValidStreamController.close();
  }
}

abstract class MyAccountViewModelInputs {
  Sink get inputUserName;

  Sink get inputPhoneNumber;

  Sink get inputGovernment;

  Sink get inputAddress;

  Sink get inputOldPassword;

  Sink get inputPassword;

  Sink get inputConfirmPassword;

  Sink get inputAllInputsValid;

  updateUserProfile();

  void setUserImage(XFile? userImage);

  setUserName(String userName);

  setMobileNumber(String mobileNumber);

  setUserGovernment(String uerGovernment);

  setAddress(String userAddress);

  setOldPassword(String oldPassword);

  setPassword(String password);

  setConfirmPassword(String confirmPassword);
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

  Stream<bool> get outputIsOldPasswordValid;

  Stream<String?> get outputErrorOldPasswordValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPasswordValid;

  Stream<bool> get outputIsConfirmPasswordValid;

  Stream<String?> get outputErrorConfirmPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
