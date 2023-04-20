import 'dart:async';

import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/item_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class ItemsScreenViewModel extends BaseViewModel
    with ItemsScreenViewModelInputs, ItemsScreenViewModelOutputs {

  final ItemUseCase _itemUseCase = instance<ItemUseCase>();

  final StreamController _contentStreamController =
  StreamController<Item>.broadcast();

  @override
  void start() {}

  @override
  void getItemData(int itemId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _itemUseCase.execute(itemId);

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


abstract class ItemsScreenViewModelInputs {
  void getItemData(int itemId);

  Sink get contentInput;
}

abstract class ItemsScreenViewModelOutputs {
  Stream<Item> get contentOutput;
}
