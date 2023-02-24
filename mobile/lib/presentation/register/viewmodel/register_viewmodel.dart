import 'dart:async';

import 'package:sed/presentation/base/baseviewmodel.dart';

class RegisterViewModel extends BaseViewModel {
  StreamController _userNameStreamController =
      StreamController<String>.broadcast();

  StreamController _mobileNumberStreamController =
      StreamController<String>.broadcast();

  StreamController _emailStreamController =
      StreamController<String>.broadcast();

  StreamController _passwordStreamController =
      StreamController<String>.broadcast();

  StreamController _areAllInputsValidStreamController =
      StreamController<String>.broadcast();

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
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;
  Sink get inputMobileNumber;
  Sink get inputEmail;
  Sink get inputPassword;
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
