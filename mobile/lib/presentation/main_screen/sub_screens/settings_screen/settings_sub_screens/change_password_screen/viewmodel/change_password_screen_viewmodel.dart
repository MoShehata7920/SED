import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:sed/app/functions.dart';
import '../../../../../../base/baseviewmodel.dart';
import '../../../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../../../resources/strings_manager.dart';

class ChangePasswordViewModel extends BaseViewModel
    with ChangePasswordViewModelInputs, ChangePasswordViewModelOutputs {
  final StreamController _oldPasswordStreamController =
      StreamController<String>.broadcast();

  final StreamController _newPasswordStreamController =
      StreamController<String>.broadcast();

  final StreamController _confirmNewPasswordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  @override
  void start() {
    inputState.add(ContentState());
  }

  // Inputs
  @override
  Sink get inputOldPassword => _oldPasswordStreamController.sink;

  @override
  Sink get inputNewPassword => _newPasswordStreamController.sink;

  @override
  Sink get inputConfirmNewPassword => _confirmNewPasswordStreamController.sink;

  @override
  Sink get inputAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setOldPassword(String oldPassword) {
    // TODO: implement setOldPassword
    throw UnimplementedError();
  }

  @override
  setNewPassword(String newPassword) {
    // TODO: implement setPassword
    throw UnimplementedError();
  }

  @override
  setConfirmNewPassword(String confirmNewPassword) {
    // TODO: implement setConfirmPassword
    throw UnimplementedError();
  }

  // Outputs
  @override
  Stream<bool> get outputIsOldPasswordValid =>
      _oldPasswordStreamController.stream
          .map((oldPassword) => _isOldPasswordValid(oldPassword));

  @override
  Stream<bool> get outputIsNewPasswordValid =>
      _newPasswordStreamController.stream
          .map((newPassword) => _isNewPasswordValid(newPassword));

  @override
  Stream<String?> get outputErrorNewPasswordValid =>
      outputIsNewPasswordValid.map((isNewPasswordValid) =>
          isNewPasswordValid ? null : AppStrings.passwordError.tr());

  @override
  Stream<bool> get outputIsConfirmNewPasswordValid =>
      _confirmNewPasswordStreamController.stream.map((confirmNewPassword) =>
          _isConfirmNewPasswordValid(confirmNewPassword));

  @override
  Stream<String?> get outputErrorConfirmNewPasswordValid =>
      outputIsConfirmNewPasswordValid.map((isConfirmNewPasswordValid) =>
          isConfirmNewPasswordValid
              ? null
              : AppStrings.confirmPasswordError.tr());

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  // Private functions
  bool _isOldPasswordValid(String oldPassword) {
    return oldPassword.isNotEmpty;
  }

  bool _isNewPasswordValid(String password) {
    return password.isPasswordValid();
  }

  bool _isConfirmNewPasswordValid(String confirmPassword) {
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

  @override
  void dispose() {
    _oldPasswordStreamController.close();
    _newPasswordStreamController.close();
    _confirmNewPasswordStreamController.close();
    _areAllInputsValidStreamController.close();
  }
}

abstract class ChangePasswordViewModelInputs {
  Sink get inputOldPassword;

  Sink get inputNewPassword;

  Sink get inputConfirmNewPassword;

  Sink get inputAllInputsValid;

  setOldPassword(String oldPassword);

  setNewPassword(String newPassword);

  setConfirmNewPassword(String confirmNewPassword);
}

abstract class ChangePasswordViewModelOutputs {
  Stream<bool> get outputIsOldPasswordValid;

  Stream<bool> get outputIsNewPasswordValid;

  Stream<String?> get outputErrorNewPasswordValid;

  Stream<bool> get outputIsConfirmNewPasswordValid;

  Stream<String?> get outputErrorConfirmNewPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
