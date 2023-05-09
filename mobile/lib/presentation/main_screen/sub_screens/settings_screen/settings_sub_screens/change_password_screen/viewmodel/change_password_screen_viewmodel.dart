import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/usecase/change_password_usecase.dart';
import 'package:sed/presentation/common/freezed_data_classes.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import '../../../../../../../app/di.dart';
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

  StreamController isUserChangedPasswordSuccessfullyStreamController =
      StreamController<bool>();

  var changePasswordObject = ChangePasswordObject("", "", "");

  final ChangePasswordUsecase _changePasswordUsecase =
      instance<ChangePasswordUsecase>();

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
    inputNewPassword.add(oldPassword);
    if (_isNewPasswordValid(oldPassword)) {
      // update oldPassword view object
      changePasswordObject =
          changePasswordObject.copyWith(oldPassword: oldPassword);
    } else {
      // reset oldPassword value in register view object
      changePasswordObject = changePasswordObject.copyWith(oldPassword: "");
    }
    validate();
  }

  @override
  setNewPassword(String newPassword) {
    inputNewPassword.add(newPassword);
    if (_isNewPasswordValid(newPassword)) {
      // update newPassword view object
      changePasswordObject =
          changePasswordObject.copyWith(newPassword: newPassword);
    } else {
      // reset newPassword value in register view object
      changePasswordObject = changePasswordObject.copyWith(newPassword: "");
    }
    validate();
  }

  @override
  setConfirmNewPassword(String confirmNewPassword) {
    inputNewPassword.add(confirmNewPassword);
    if (_isNewPasswordValid(confirmNewPassword)) {
      // update confirmNewPassword view object
      changePasswordObject =
          changePasswordObject.copyWith(confirmNewPassword: confirmNewPassword);
    } else {
      // reset confirmNewPassword value in register view object
      changePasswordObject =
          changePasswordObject.copyWith(confirmNewPassword: "");
    }
    validate();
  }

  // Outputs
  @override
  Stream<bool> get outputIsOldPasswordValid =>
      _oldPasswordStreamController.stream
          .map((oldPassword) => _isOldPasswordValid(oldPassword));

  @override
  Stream<String?> get outputErrorOldPasswordValid =>
      outputIsOldPasswordValid.map((isOldPasswordValid) =>
          isOldPasswordValid ? null : AppStrings.passwordError);

  @override
  Stream<bool> get outputIsNewPasswordValid =>
      _newPasswordStreamController.stream
          .map((newPassword) => _isNewPasswordValid(newPassword));

  @override
  Stream<String?> get outputErrorNewPasswordValid =>
      outputIsNewPasswordValid.map((isNewPasswordValid) =>
          isNewPasswordValid ? null : AppStrings.passwordInValid);

  @override
  Stream<bool> get outputIsConfirmNewPasswordValid =>
      _confirmNewPasswordStreamController.stream.map((confirmNewPassword) =>
          _isConfirmNewPasswordValid(confirmNewPassword));

  @override
  Stream<String?> get outputErrorConfirmNewPasswordValid =>
      outputIsConfirmNewPasswordValid.map((isConfirmNewPasswordValid) =>
          isConfirmNewPasswordValid
              ? null
              : AppStrings.confirmPasswordError);

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
    return changePasswordObject.newPassword == confirmPassword;
  }

  bool _areAllInputsValid() {
    return changePasswordObject.oldPassword.isNotEmpty &&
        changePasswordObject.newPassword.isNotEmpty &&
        changePasswordObject.confirmNewPassword.isNotEmpty;
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
    isUserChangedPasswordSuccessfullyStreamController.close();
  }

  @override
  changePassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _changePasswordUsecase.execute(
        ChangePasswordUsecaseInput(
            Constants.userId ?? "",
            changePasswordObject.oldPassword,
            changePasswordObject.newPassword,
            changePasswordObject.confirmNewPassword));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popUpErrorState, failure.message))
            }, (response) {
      // right -> success
      inputState.add(SuccessState(StateRendererType.popUpSuccessState,
          "Successfully changed password", AppStrings.success.tr(), () {}));

      // navigate to main screen
      isUserChangedPasswordSuccessfullyStreamController.add(true);
    });
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

  changePassword();
}

abstract class ChangePasswordViewModelOutputs {
  Stream<bool> get outputIsOldPasswordValid;

  Stream<String?> get outputErrorOldPasswordValid;

  Stream<bool> get outputIsNewPasswordValid;

  Stream<String?> get outputErrorNewPasswordValid;

  Stream<bool> get outputIsConfirmNewPasswordValid;

  Stream<String?> get outputErrorConfirmNewPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
