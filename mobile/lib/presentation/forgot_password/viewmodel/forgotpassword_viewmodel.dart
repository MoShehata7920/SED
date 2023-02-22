import 'dart:async';

import 'package:sed/domain/usecase/forgotpassword_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController = StreamController<String>.broadcast();
  String forgotPasswordEmail = AppStrings.empty;

  final ForgotPasswordUseCase _forgotPasswordUseCase;

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    _emailStreamController.close();
  }

  @override
  Sink get emailInput => _emailStreamController.sink;

  @override
  Stream<bool> get outIsEmailValid =>
      _emailStreamController.stream.map((email) => isEmailValid(email));

  bool isEmailValid(String email) {
    return email.isNotEmpty;
  }

  void setEmail(String email) {
    forgotPasswordEmail = email;

    emailInput.add(email);
  }

  @override
  resetPassword() async {
       var response = await _forgotPasswordUseCase
        .execute(ForgotPasswordInput(forgotPasswordEmail));
  }
}

abstract class ForgotPasswordViewModelInputs {
  Sink get emailInput;

  void resetPassword();
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
}
