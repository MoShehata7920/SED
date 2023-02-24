import 'dart:async';

import 'package:sed/app/functions.dart';
import 'package:sed/domain/usecase/register_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import '../../common/freezed_data_classes.dart';

class RegisterViewModel extends BaseViewModel
    with RegisterViewModelInputs, RegisterViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  final StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<String>.broadcast();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "");
  RegisterViewModel(this._registerUseCase);

  // inputs
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();

    super.dispose();
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _mobileNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  setUserName(String userName) {
    if (_isUserNameValid(userName)) {
      // update register view object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset userName value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
  }

  @override
  setMobileCountryCode(String mobileCountryCode) {
    if (mobileCountryCode.isNotEmpty) {
      // update countryCode view object
      registerObject =
          registerObject.copyWith(countryMobileCode: mobileCountryCode);
    } else {
      // reset countryCode value in register view object
      registerObject = registerObject.copyWith(countryMobileCode: "");
    }
  }

  @override
  setMobileNumber(String mobileNumber) {
    if (_isMobileNumberValid(mobileNumber)) {
      // update email view object
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
  }

  @override
  setEmail(String email) {
    if (_isEmailValid(email)) {
      // update email view object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
  }

  @override
  setPassword(String password) {
    if (_isPasswordValid(password)) {
      // update email view object
      registerObject = registerObject.copyWith(mobileNumber: password);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
  }

  @override
  register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  // outputs
  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserNameValid => outputIsUserNameValid
      .map((isUserNAme) => isUserNAme ? null : AppStrings.userNameInValid);

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _mobileNumberStreamController.stream
          .map((mobileNumber) => _isMobileNumberValid(mobileNumber));

  @override
  Stream<String?> get outputErrorMobileNumberValid =>
      outputIsMobileNumberValid.map((isMobileNumberValid) =>
          isMobileNumberValid ? null : AppStrings.mobileNumberInValid);

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((email) => _isEmailValid(email));

  @override
  Stream<String?> get outputErrorEmailValid => outputIsEmailValid
      .map((isEmailValid) => isEmailValid ? null : AppStrings.emailInValid);

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<String?> get outputErrorPasswordValid => outputIsPasswordValid.map(
      (isPasswordValid) => isPasswordValid ? null : AppStrings.passwordInValid);

  // private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 6;
  }

  bool _isEmailValid(String userName) {
    return userName.isValidEmail();
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 11;
  }

  bool _isPasswordValid(String password) {
    return password.isPasswordValid();
  }
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;

  register();

  setUserName(String userName);
  setMobileCountryCode(String mobileCountryCode);
  setMobileNumber(String mobileNumber);
  setEmail(String email);
  setPassword(String password);
}

abstract class RegisterViewModelOutputs {
  Stream<bool> get outputIsUserNameValid;
  Stream<String?> get outputErrorUserNameValid;

  Stream<bool> get outputIsMobileNumberValid;
  Stream<String?> get outputErrorMobileNumberValid;

  Stream<bool> get outputIsEmailValid;
  Stream<String?> get outputErrorEmailValid;

  Stream<bool> get outputIsPasswordValid;
  Stream<String?> get outputErrorPasswordValid;
}
