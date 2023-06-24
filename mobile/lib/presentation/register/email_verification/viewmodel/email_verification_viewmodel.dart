import 'dart:async';

import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/usecase/verify_email_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';

import '../../../common/state_renderer/state_renderer.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';

class VerifyEmailViewModel extends BaseViewModel
    with VerifyEmailViewModelInputs, VerifyEmailViewModelOutputs {
  final VerifyEmailUseCase _verifyEmailUseCase = instance<VerifyEmailUseCase>();

  StreamController isUserLoggedInSuccessfullyStreamController =
      StreamController<bool>();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void start() {}

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    isUserLoggedInSuccessfullyStreamController.close();
  }

  @override
  void verifyEmail(int code) async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _verifyEmailUseCase.execute(code);

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.popUpErrorState, failure.message))
            }, (response) {
      // right -> success
      inputState.add(ContentState());

      // navigate to main screen

      _appPreferences.setToken(Constants.token);

      isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }
}

abstract class VerifyEmailViewModelInputs {
  void verifyEmail(int code);
}

abstract class VerifyEmailViewModelOutputs {}
