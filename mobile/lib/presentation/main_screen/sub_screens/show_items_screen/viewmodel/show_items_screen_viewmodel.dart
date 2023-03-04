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

  List<Items> items = <Items> [];

  @override
  void start() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void getItems(Views viewType) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response =
        await _showItemsUseCase.execute(ShowItemsUseCaseInputs(viewType.getViewId(), 0));

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success
      items = response.items;

      inputState.add(ContentState());
    });
  }
}

abstract class ShowItemsViewModelInputs {
  void getItems(Views viewType);
}

abstract class ShowItemsViewModelOutputs {}
