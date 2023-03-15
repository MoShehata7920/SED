import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/usecase/forgotpassword_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sprintf/sprintf.dart';
import '../../common/state_renderer/state_renderer.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController =
      StreamController<String>.broadcast();

  final StreamController _showResendStreamController =
      StreamController<bool>.broadcast();

  String forgotPasswordEmail = AppStrings.empty;

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  int _secondsLeft = 10;

  Timer? _timer;

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _emailStreamController.close();

    _timer?.cancel();
  }

  // inputs
  @override
  forgotPassword() async {
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.popUpLoadingState));

    var response = await _forgotPasswordUseCase.execute(forgotPasswordEmail);

    response.fold((failure) {
      // left -> failure
      inputState
          .add(ErrorState(StateRendererType.popUpErrorState, failure.message));
    }, (response) {
      // right -> success
      inputState.add(SuccessState(
          StateRendererType.popUpSuccessState, response, AppStrings.success.tr(),(){}));

      _showResendStreamController.add(true);

    });

    _initTimers();
  }

  void setEmail(String email) {
    forgotPasswordEmail = email;

    emailInput.add(email);
  }

  @override
  Sink get emailInput => _emailStreamController.sink;

  @override
  Sink get showResendInput => _showResendStreamController.sink;

  // outputs
  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  @override
  Stream<bool> get outShowResend =>
      _showResendStreamController.stream.map((show) => show);

  bool isEmailValid(String email) {
    return email.isValidEmail();
  }

  void _initTimers() {
    _timer = Timer.periodic(
        const Duration(
          milliseconds: 1000,
        ),
        _onTick);
  }

  void _onTick(timer) async {
    if (_secondsLeft == 0) {
      _timer?.cancel();

      _secondsLeft = 10;

      _showResendStreamController.add(false);
    } else {
      _secondsLeft--;

      _showResendStreamController.add(true);
    }
  }

  String getResendText() => sprintf(AppStrings.resendText.tr(), [_secondsLeft]);
}

abstract class ForgotPasswordViewModelInputs {
  Sink get emailInput;

  Sink get showResendInput;

  forgotPassword();
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;

  Stream<bool> get outShowResend;
}
