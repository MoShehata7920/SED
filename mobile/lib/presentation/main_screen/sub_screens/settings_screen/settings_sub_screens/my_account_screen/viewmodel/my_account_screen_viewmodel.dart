import 'package:sed/presentation/base/baseviewmodel.dart';

class MyAccountViewModel extends BaseViewModel
    with MyAccountViewModelInputs, MyAccountViewModelOutputs {
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

abstract class MyAccountViewModelInputs {}

abstract class MyAccountViewModelOutputs {}
