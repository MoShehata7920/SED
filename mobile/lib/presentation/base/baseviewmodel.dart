import 'dart:async';

import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

abstract class BaseViewModel extends BaseViewModelInputs
    with BaseViewModelOutputs {
  //abstract why ? cause other view models will inherit its functions
  //so it will be containing all the shared functions and variables
  //for example if we have 100 view class and all of them have a function to add two numbers
  //instead of implementing it 100 times we can implement it 1 time at the base

  final StreamController _inputStreamController =
      StreamController<FlowState>.broadcast();

  @override
  void dispose() {
    _inputStreamController.close();
  }

  @override
  Sink get inputState => _inputStreamController.sink;

  @override
  Stream<FlowState> get outputState =>
      _inputStreamController.stream.map((flowState) => flowState);
}

abstract class BaseViewModelInputs {
  void start(); //start viewmodel job

  void dispose(); //will be called when viewmodel dies

  Sink get inputState;
}

abstract class BaseViewModelOutputs {
  Stream<FlowState> get outputState;
}
