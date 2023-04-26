import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:sed/app/di.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/get_saved_products.dart';
import 'package:sed/domain/usecase/saving_products_usecase.dart';
import 'package:sed/domain/usecase/show_items_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';

class ShowItemsViewModel extends BaseViewModel
    with ShowItemsViewModelInputs, ShowItemsViewModelOutputs {
  final ShowItemsUseCase _showItemsUseCase = instance<ShowItemsUseCase>();
  final GetSavedProductsUseCase _getSavedProductsUseCase =
      instance<GetSavedProductsUseCase>();

  final StreamController _contentStreamController =
      StreamController<ShowItemsContentObject>.broadcast();

  final SavingProductsUseCase _savingProductsUseCase =
      instance<SavingProductsUseCase>();

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
  void getItems(Views viewType,
      {String categoryName = "all", String? image}) async {
    items = [];

    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var purposeName = "all";

    if (viewType != Views.CATEGORY) {
      purposeName = viewType.getName();
    }

    Either<Failure, ShowItems> response;

    if (viewType == Views.SAVED) {
      response = await _getSavedProductsUseCase.execute(null);
    } else {
      response = await _showItemsUseCase.execute(
          ShowItemsUseCaseInputs(category: categoryName, purpose: purposeName));
    }

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success

      // if (viewType == Views.SAVED) {
      //   for (var element in response.items) {
      //     if (element.isSaved) {
      //       items.add(element);
      //     }
      //   }
      // } else {
      //   items = response.items;
      // }
      items = response.items;
      contentInput.add(ShowItemsContentObject(items));
    });

    inputState.add(ContentState());
  }

  @override
  void toggleSavingProduct(String productId) async {
    var product = items.firstWhere((element) => element.id == productId);

    int index = items.indexOf(product);

    items.remove(product);

    contentInput.add(ShowItemsContentObject(items));

    var response = await _savingProductsUseCase
        .execute(SavingProductUseCaseInputs(productId));

    response.fold(
        (failure) => {
              items.insert(index, product),
              contentInput.add(ShowItemsContentObject(items))
            },
        (response) {});
  }

  @override
  Future getMoreItems(Views viewType, String categoryName, int pageId) async {
    inputState.add(ContentState());

    var categoryName = "all";
    var purposeName = "all";

    if (viewType == Views.CATEGORY) {
      categoryName = viewType.getName(categoryId: 1);
    } else {
      purposeName = viewType.getName();
    }

    var response = await _showItemsUseCase.execute(ShowItemsUseCaseInputs(
        category: categoryName, purpose: purposeName, page: pageId));

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success

      for (var element in response.items) {
        if (viewType == Views.SAVED) {
          if (element.isSaved) {
            items.add(element);
          }
        } else {
          items.add(element);
        }
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
  void getItems(Views viewType, {String categoryName = "all", String? image});

  void getMoreItems(Views viewType, String categoryName, int pageId);

  void toggleSavingProduct(String productId);

  Sink get contentInput;
}

abstract class ShowItemsViewModelOutputs {
  Stream<ShowItemsContentObject> get contentOutput;
}
