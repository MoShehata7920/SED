import 'dart:async';

import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/home_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class HomeScreenViewModel extends BaseViewModel
    with HomeScreenViewModelInputs, HomeScreenViewModelOutputs {
  List<String?> carouselImages = [];
  List<Category?> categories = [];

  final HomeUseCase _homeUseCase = instance<HomeUseCase>();

  final StreamController _carouselStreamController =
      StreamController<void>.broadcast();

  int carouselCurrentIndex = 0;

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _carouselStreamController.close();
    super.dispose();
  }

  void onPageChanged(int index) {
    carouselCurrentIndex = index;

    carouselInput.add(null);
  }

  @override
  Sink get carouselInput => _carouselStreamController.sink;

  @override
  Stream<void> get carouselOutput =>
      _carouselStreamController.stream.map((index) => () {});

  void getHomeData() async{
    inputState.add(
        LoadingState(stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _homeUseCase.execute(null);

    response.fold(
            (failure) => {
          // left -> failure
        }, (response) {
      // right -> success
      // navigate to main screen
      carouselImages = response.carousel!.images;
      categories = response.category!;

      inputState.add(ContentState());
    });
  }
}

abstract class HomeScreenViewModelInputs {
  Sink get carouselInput;
}

abstract class HomeScreenViewModelOutputs {
  Stream<void> get carouselOutput;
}
