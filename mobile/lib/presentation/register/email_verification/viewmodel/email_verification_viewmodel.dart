import 'package:sed/app/di.dart';
import 'package:sed/domain/usecase/verify_email_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';

import '../../../common/state_renderer/state_renderer.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';

class VerifyEmailViewModel extends BaseViewModel
    with VerifyEmailViewModelInputs, VerifyEmailViewModelOutputs {
  final VerifyEmailUseCase _verifyEmailUseCase = instance<VerifyEmailUseCase>();

  @override
  void start() {}

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

      print(response);
      // navigate to main screen

      // _appPreferences.setToken(response.token ?? AppStrings.empty);

      // isUserLoggedInSuccessfullyStreamController.add(true);
    });
  }
}

abstract class VerifyEmailViewModelInputs {
  void verifyEmail(int code);
}

abstract class VerifyEmailViewModelOutputs {}
