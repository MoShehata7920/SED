import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/home_usecase.dart';
import 'package:sed/domain/usecase/saving_products_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';

class HomeScreenViewModel extends BaseViewModel
    with HomeScreenViewModelInputs, HomeScreenViewModelOutputs {
  final HomeUseCase _homeUseCase = instance<HomeUseCase>();

  final StreamController _carouselStreamController =
      StreamController<void>.broadcast();

  final StreamController _savedStreamController =
      StreamController<bool>.broadcast();

  final StreamController _contentStreamController =
      StreamController<HomeContentObject>.broadcast();

  final SavingProductsUseCase _savingProductsUseCase =
      instance<SavingProductsUseCase>();

  int carouselCurrentIndex = 0;

  // Inputs

  @override
  void start() async {
    inputState.add(ContentState());

    getHomeData();
  }

  @override
  void dispose() {
    _carouselStreamController.close();
    _savedStreamController.close();
    _contentStreamController.close();
    super.dispose();
  }

  void onPageChanged(int index) {
    carouselCurrentIndex = index;

    carouselInput.add(null);
  }

  @override
  Sink get carouselInput => _carouselStreamController.sink;

  @override
  Sink get savedInput => _savedStreamController.sink;

  @override
  Sink get contentInput => _contentStreamController.sink;

  // Outputs

  @override
  Stream<void> get carouselOutput =>
      _carouselStreamController.stream.map((index) => () {});

  @override
  Stream<bool> get savedOutput =>
      _savedStreamController.stream.map((event) => event);

  @override
  Stream<HomeContentObject> get contentOutput => _contentStreamController.stream
      .map((homeContentObject) => homeContentObject);

  // private functions
  void getHomeData() async {

    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _homeUseCase.execute(null);

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success
      // post data to view

      Utils.categories = response.category;

      contentInput.add(HomeContentObject(
          response.carousel.images,
          response.sellItems,
          response.donateItems,
          response.exchangeItems,
          response.sections));

      inputState.add(ContentState());
    });
  }

  @override
  void toggleSavingProduct(Items product) async {
    product.isSaved = !product.isSaved;

    savedInput.add(true);

    var response = await _savingProductsUseCase
        .execute(SavingProductUseCaseInputs(product.id));

    response.fold(
        (failure) => {
              // left -> failure
              product.isSaved = false,
              savedInput.add(true)
            }, (response) {
      // right -> success
    });
  }
}

abstract class HomeScreenViewModelInputs {
  Sink get carouselInput;

  Sink get savedInput;

  Sink get contentInput;

  void toggleSavingProduct(Items product);
}

abstract class HomeScreenViewModelOutputs {
  Stream<void> get carouselOutput;

  Stream<bool> get savedOutput;

  Stream<HomeContentObject> get contentOutput;
}
