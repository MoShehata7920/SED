abstract class BaseViewModel {
  // shared variables and functions that will be used through any view model

}

abstract class BaseViewModelInputs {
  void start(); //start viewModel job

  void dispose(); //will be called when view model dies
}

abstract class BaseViewModelOutputs {}
