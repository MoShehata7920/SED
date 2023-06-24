import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../domain/usecase/login_usecase.dart';
import '../../common/freezed_data_classes.dart';

class LoginViewModel extends BaseViewModel
    with LoginViewModelInputs, LoginViewModelOutputs {
  final StreamController _userNameStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordStreamController =
      StreamController<String>.broadcast();
  final StreamController _passwordVisibilityController =
      StreamController<void>.broadcast();

  // for login button to activate it or disable it
  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  // i didn't create it as private bc i will call it in view directly
  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  final LoginUseCase _loginUseCase;

  LoginViewModel(this._loginUseCase);

  var loginObject = LoginObject("", "");

  IconData passwordSuffixIcon = IconsManager.passwordVisible;

  bool obscureText = true;

  bool isVerified = true;

  // inputs
  @override
  void dispose() {
    super.dispose();
    _userNameStreamController.close();
    _passwordStreamController.close();
    _areAllInputsValidStreamController.close();
    _passwordVisibilityController.close();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void start() {
    //view model should tell view show content state

    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputAreAllInputsValid.add(null);
  }

  @override
  setUserName(String userName) {
    inputUserName.add(userName);
    loginObject = loginObject.copyWith(userName: userName);
    inputAreAllInputsValid.add(null);
  }

  @override
  login() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _loginUseCase
        .execute(LoginUseCaseInput(loginObject.userName, loginObject.password));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popUpErrorState, failure.message))
            }, (response) {
      _appPreferences.setToken(response.token ?? AppStrings.empty);

      // Utils.getUserId();
      // right -> success
      inputState.add(ContentState());
      // navigate to main screen

      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }

  // for login button to activate it or disable it
  @override
  Sink get inputAreAllInputsValid => _areAllInputsValidStreamController.sink;

  // outputs
  @override
  Stream<bool> get outIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  // for login button to activate it or disable it
  @override
  Stream<bool> get outAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  bool _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  bool _isUserNameValid(String userName) {
    return userName.isValidEmail();
  }

  bool _areAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.userName);
  }

  @override
  togglePasswordVisibility() {
    obscureText = !obscureText;

    if (obscureText) {
      passwordSuffixIcon = IconsManager.passwordVisible;
    } else {
      passwordSuffixIcon = IconsManager.passwordNotVisible;
    }

    inputPasswordVisible.add(null);
  }

  @override
  Sink get inputPasswordVisible => _passwordVisibilityController.sink;

  @override
  Stream<bool> get outIsPasswordVisible =>
      _passwordVisibilityController.stream.map((event) => true);
}

abstract class LoginViewModelInputs {
  setUserName(String userName);

  setPassword(String password);

  login();

  togglePasswordVisibility();

  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputPasswordVisible;

  // for login button to activate it or disable it
  Sink get inputAreAllInputsValid;
}

abstract class LoginViewModelOutputs {
  Stream<bool> get outIsUserNameValid;

  Stream<bool> get outIsPasswordValid;

  Stream<bool> get outIsPasswordVisible;

  // for login button to activate it or disable it
  Stream<bool> get outAreAllInputsValid;
}
