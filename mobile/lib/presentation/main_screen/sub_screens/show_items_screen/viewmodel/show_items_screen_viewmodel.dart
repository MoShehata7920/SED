import 'dart:async';

import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/show_items_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';

class ShowItemsViewModel extends BaseViewModel
    with ShowItemsViewModelInputs, ShowItemsViewModelOutputs {
  final ShowItemsUseCase _showItemsUseCase = instance<ShowItemsUseCase>();

  final StreamController _contentStreamController =
      StreamController<ShowItemsContentObject>.broadcast();

  List<Items> items = [];

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    _contentStreamController.close();
    super.dispose();
  }

  @override
  void getItems(Views viewType, int categoryId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _showItemsUseCase.execute(
        ShowItemsUseCaseInputs(viewType.getName(categoryId: categoryId), 0));

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success
      items = response.items;

      contentInput.add(ShowItemsContentObject(items));
    });

    inputState.add(ContentState());
  }

  @override
  Future getMoreItems(Views viewType, int categoryId, int pageId) async {
    inputState.add(ContentState());

    var response = await _showItemsUseCase.execute(ShowItemsUseCaseInputs(
        viewType.getName(categoryId: categoryId), pageId));

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success

      for (var element in response.items) {
        items.add(element);
      }

      contentInput.add(ShowItemsContentObject(items));

      inputState.add(ContentState());
    });
  }

  @override
  Sink get contentInput => _contentStreamController.sink;

  @override
  Stream<ShowItemsContentObject> get contentOutput =>
      _contentStreamController.stream
          .map((showItemsContentObject) => showItemsContentObject);
}

abstract class ShowItemsViewModelInputs {
  void getItems(Views viewType, int categoryId);

  void getMoreItems(Views viewType, int categoryId, int pageId);

  Sink get contentInput;
}

abstract class ShowItemsViewModelOutputs {
  Stream<ShowItemsContentObject> get contentOutput;
}
