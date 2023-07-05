import 'dart:async';
import 'package:sed/app/di.dart';
import 'package:sed/domain/usecase/verify_email_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import '../../../common/state_renderer/state_renderer.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';

class ResetPasswordOTPViewModel extends BaseViewModel
    with ResetPasswordOTPViewModelInputs, ResetPasswordOTPViewModelOutputs {
  final VerifyEmailUseCase _resetPasswordOtpUseCase =
      instance<VerifyEmailUseCase>();

  StreamController isEmailVerifiedSuccessfullyStreamController =
      StreamController<bool>();

  @override
  void start() {}

  @override
  void dispose() {
    super.dispose();
    isEmailVerifiedSuccessfullyStreamController.close();
  }

  @override
  void resetPasswordOtp(int code) async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _resetPasswordOtpUseCase.execute(code);

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popUpErrorState, failure.message))
            }, (response) {
      // right -> success
      inputState.add(ContentState());

      // navigate to main screen

      isEmailVerifiedSuccessfullyStreamController.add(true);
    });
  }
}

abstract class ResetPasswordOTPViewModelInputs {
  void resetPasswordOtp(int code);
}

abstract class ResetPasswordOTPViewModelOutputs {}
