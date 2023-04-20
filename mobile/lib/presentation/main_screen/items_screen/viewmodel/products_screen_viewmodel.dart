import 'dart:async';

import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/item_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class ProductScreenViewModel extends BaseViewModel
    with ProductScreenViewModelInputs, ProductScreenViewModelOutputs {

  final ProductUseCase _productUseCase = instance<ProductUseCase>();

  final StreamController _contentStreamController =
  StreamController<Item>.broadcast();

  @override
  void start() {}

  @override
  void getProductData(String productId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _productUseCase.execute(productId);

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenLoadingState, failure.message))
            }, (response) {
      // right -> success

      contentInput.add(response);

      inputState.add(ContentState());
    });
  }

  @override
  void dispose() {
    _contentStreamController.close();
    super.dispose();
  }

  @override
  Sink get contentInput => _contentStreamController.sink;

  @override
  Stream<Item> get contentOutput =>
      _contentStreamController.stream
          .map((item) => item);
}


abstract class ProductScreenViewModelInputs {
  void getProductData(String productId);

  Sink get contentInput;
}

abstract class ProductScreenViewModelOutputs {
  Stream<Item> get contentOutput;
}
