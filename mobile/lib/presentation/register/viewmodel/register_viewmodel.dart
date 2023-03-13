import 'dart:async';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/usecase/register_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../common/freezed_data_classes.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

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
      StreamController<void>.broadcast();

  StreamController isUserRegisteredSuccessfullyStreamController =
      StreamController<bool>();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  final RegisterUseCase _registerUseCase;
  var registerObject = RegisterObject("", "", "", "", "");

  RegisterViewModel(this._registerUseCase);

  // inputs
  @override
  void start() {
    inputState.add(ContentState());

    setMobileCountryCode('EG');
  }

  @override
  void dispose() {
    _userNameStreamController.close();
    _mobileNumberStreamController.close();
    _emailStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserRegisteredSuccessfullyStreamController.close();

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
    inputUserName.add(userName);

    if (_isUserNameValid(userName)) {
      // update register view object
      registerObject = registerObject.copyWith(userName: userName);
    } else {
      // reset userName value in register view object
      registerObject = registerObject.copyWith(userName: "");
    }
    validate();
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
    validate();
  }

  @override
  setMobileNumber(String mobileNumber) {
    inputMobileNumber.add(mobileNumber);

    if (_isMobileNumberValid(mobileNumber)) {
      // update email view object
      registerObject = registerObject.copyWith(mobileNumber: mobileNumber);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(mobileNumber: "");
    }
    validate();
  }

  @override
  setEmail(String email) {
    inputEmail.add(email);

    if (_isEmailValid(email)) {
      // update email view object
      registerObject = registerObject.copyWith(email: email);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(email: "");
    }
    validate();
  }

  @override
  setPassword(String password) {
    inputPassword.add(password);

    if (_isPasswordValid(password)) {
      // update email view object
      registerObject = registerObject.copyWith(password: password);
    } else {
      // reset email value in register view object
      registerObject = registerObject.copyWith(password: "");
    }
    validate();
  }

  @override
  Sink get inputAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  register() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _registerUseCase.execute(RegisterUseCaseInput(
        registerObject.userName,
        registerObject.countryMobileCode,
        registerObject.mobileNumber,
        registerObject.email,
        registerObject.password));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popUpErrorState, failure.message))
            }, (response) {

      _appPreferences.setToken(response.token ?? AppStrings.empty);

      // right -> success
      //inputState.add(SuccessState(StateRendererType.popUpSuccessState, response.token.toString(), AppStrings.success));
      isUserRegisteredSuccessfullyStreamController.add(true);
    });
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

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  // private functions
  bool _isUserNameValid(String userName) {
    return userName.length >= 6;
  }

  bool _isEmailValid(String userName) {
    return userName.isValidEmail();
  }

  bool _isMobileNumberValid(String mobileNumber) {
    return mobileNumber.length >= 9;
  }

  bool _isPasswordValid(String password) {
    return password.isPasswordValid();
  }

  bool _areAllInputsValid() {
    return registerObject.userName.isNotEmpty &&
        registerObject.countryMobileCode.isNotEmpty &&
        registerObject.mobileNumber.isNotEmpty &&
        registerObject.email.isNotEmpty &&
        registerObject.password.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }
}

abstract class RegisterViewModelInputs {
  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputAllInputsValid;

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

  Stream<bool> get outputAreAllInputsValid;
}
