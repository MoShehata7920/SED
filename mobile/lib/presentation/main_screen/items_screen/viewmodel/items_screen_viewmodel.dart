import 'package:flutter/cupertino.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/item_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class ItemsScreenViewModel extends BaseViewModel
    with ItemsScreenViewModelInputs, ItemsScreenViewModelOutputs {
  Item item = Item(Items(0, "", "", 0, "", 0, ""), UserData("", "", "", ""));
  final ItemUseCase _itemUseCase = instance<ItemUseCase>();

  @override
  void start() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void getItemData(int itemId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _itemUseCase.execute(itemId);

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success
      // navigate to main screen

      // exchangeItems = response.exchangeItems;
      item = response;
      inputState.add(ContentState());
    });
  }
}

abstract class ItemsScreenViewModelInputs {
  void getItemData(int itemId);
}

abstract class ItemsScreenViewModelOutputs {}
