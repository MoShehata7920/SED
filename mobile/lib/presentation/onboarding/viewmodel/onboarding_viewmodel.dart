import 'dart:async';
import '../../../domain/model/models.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> _list;
  int _currentIndex = 0;

  //OnBoarding View Model Inputs

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    // view model start ur job
    _list = _getSliderData();

    _postDataToView();
  }

  @override
  int goNext() {
    int nextIndex = ++_currentIndex;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  @override
  int goPrevious() {
    int previousIndex = --_currentIndex;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  @override
  void onPageChanged(int index) {
    _currentIndex = index;

    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  //OnBoarding View Model Outputs
  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  //OnBoarding private functions
  List<SliderObject> _getSliderData() {
    List<SliderObject> tempList = [];

    for (int i = 0; i < 3; i++) {
      tempList.add(SliderObject(AppStrings.onBoardingTitles[i],
          AppStrings.onBoardingSubTitles[i], ImageAssets.onBoardingLogos[i]));
    }

    return tempList;
  }

  void _postDataToView() {
    inputSliderViewObject.add(
        SliderViewObject(_list[_currentIndex], _list.length, _currentIndex));
  }
}

//inputs means "orders" that our view model will receive from view
abstract class OnBoardingViewModelInputs {
  int goNext(); //when user clicks on right arrow or swipe left

  int goPrevious(); //when user clicks on left arrow or swipe right

  void onPageChanged(int index); //when the user toggle between pages

  // stream controller input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  // stream controller output
  Stream<SliderViewObject> get outputSliderViewObject;
}
