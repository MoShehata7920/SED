import 'dart:async';

import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

class ForgotPasswordViewModel extends BaseViewModel
    with ForgotPasswordViewModelInputs, ForgotPasswordViewModelOutputs {
  final StreamController _emailStreamController = StreamController<String>();
  String forgotPasswordEmail = AppStrings.empty;

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
}

abstract class ForgotPasswordViewModelInputs {
  Sink get emailInput;
}

abstract class ForgotPasswordViewModelOutputs {
  Stream<bool> get outIsEmailValid;
}
