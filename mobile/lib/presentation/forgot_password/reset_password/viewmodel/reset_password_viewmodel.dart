import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/usecase/reset_password_usecase.dart';
import 'package:sed/presentation/common/freezed_data_classes.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../base/baseviewmodel.dart';

class ResetPasswordViewmodel extends BaseViewModel
    with ResetPasswordViewmodelInputs, ResetPasswordViewmodelOutputs {
  final StreamController _newPasswordStreamController =
      StreamController<String>.broadcast();

  final StreamController _confirmNewPasswordStreamController =
      StreamController<String>.broadcast();

  final StreamController _areAllInputsValidStreamController =
      StreamController<void>.broadcast();

  StreamController isUserRestedPasswordSuccessfullyStreamController =
      StreamController<bool>();

  var resetPasswordObject = ResetPasswordObject("", "");

  final ResetPasswordUsecase _resetPasswordUsecase =
      instance<ResetPasswordUsecase>();

  @override
  void start() {
    inputState.add(ContentState());
  }

  // Inputs
  @override
  Sink get inputNewPassword => _newPasswordStreamController.sink;

  @override
  Sink get inputConfirmNewPassword => _confirmNewPasswordStreamController.sink;

  @override
  Sink get inputAllInputsValid => _areAllInputsValidStreamController.sink;

  @override
  setNewPassword(String newPassword) {
    inputNewPassword.add(newPassword);
    if (_isNewPasswordValid(newPassword)) {
      // update newPassword view object
      resetPasswordObject =
          resetPasswordObject.copyWith(newPassword: newPassword);
    } else {
      // reset newPassword value in register view object
      resetPasswordObject = resetPasswordObject.copyWith(newPassword: "");
    }
    validate();
  }

  @override
  setConfirmNewPassword(String confirmNewPassword) {
    inputNewPassword.add(confirmNewPassword);
    if (_isNewPasswordValid(confirmNewPassword)) {
      // update confirmNewPassword view object
      resetPasswordObject =
          resetPasswordObject.copyWith(confirmNewPassword: confirmNewPassword);
    } else {
      // reset confirmNewPassword value in register view object
      resetPasswordObject =
          resetPasswordObject.copyWith(confirmNewPassword: "");
    }
    validate();
  }

  // Outputs
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
          isConfirmNewPasswordValid ? null : AppStrings.confirmPasswordError);

  @override
  Stream<bool> get outputAreAllInputsValid =>
      _areAllInputsValidStreamController.stream
          .map((_) => _areAllInputsValid());

  // Private functions
  bool _isNewPasswordValid(String password) {
    return password.isPasswordValid();
  }

  bool _isConfirmNewPasswordValid(String confirmPassword) {
    return resetPasswordObject.newPassword == confirmPassword;
  }

  bool _areAllInputsValid() {
    return resetPasswordObject.newPassword.isNotEmpty &&
        resetPasswordObject.confirmNewPassword.isNotEmpty;
  }

  validate() {
    inputAllInputsValid.add(null);
  }
  

  @override
  resetPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _resetPasswordUsecase.execute(
        ResetPasswordUsecaseInput(
            resetPasswordObject.newPassword,
            resetPasswordObject.confirmNewPassword));

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
      isUserRestedPasswordSuccessfullyStreamController.add(true);
    });
  }

  @override
  void dispose() {
    _newPasswordStreamController.close();
    _confirmNewPasswordStreamController.close();
    _areAllInputsValidStreamController.close();
    isUserRestedPasswordSuccessfullyStreamController.close();
  }
}

abstract class ResetPasswordViewmodelInputs {
  Sink get inputNewPassword;

  Sink get inputConfirmNewPassword;

  Sink get inputAllInputsValid;

  setNewPassword(String newPassword);

  setConfirmNewPassword(String confirmNewPassword);

  resetPassword();
}

abstract class ResetPasswordViewmodelOutputs {
  Stream<bool> get outputIsNewPasswordValid;

  Stream<String?> get outputErrorNewPasswordValid;

  Stream<bool> get outputIsConfirmNewPasswordValid;

  Stream<String?> get outputErrorConfirmNewPasswordValid;

  Stream<bool> get outputAreAllInputsValid;
}
