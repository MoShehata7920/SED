import 'dart:async';

import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/delete_item_usecase.dart';
import 'package:sed/domain/usecase/myprofile_get_ads_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class MyAdsViewModel extends BaseViewModel
    with MyAdsViewModelInputs, MyAdsViewModelOutputs {
  final StreamController _contentStreamController =
      StreamController<GetMyProfileAds>.broadcast();

  final MyProfileAdsUseCase _myProfileAdsUseCase =
      instance<MyProfileAdsUseCase>();

  final RemoveAdUseCase _removeAdUseCase = instance<RemoveAdUseCase>();

  List<Items> items = <Items>[];

  @override
  void start() {
    inputState.add(ContentState());

    getMyProfileAds();
  }

  @override
  void dispose() {
    _contentStreamController.close();

    super.dispose();
  }

  @override
  Sink get contentInput => _contentStreamController.sink;

  @override
  Stream<GetMyProfileAds> get contentOutput =>
      _contentStreamController.stream.map((myProfileAds) => myProfileAds);

  @override
  void getMyProfileAds() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _myProfileAdsUseCase
        .execute(GetMyProfileAdsInput(Constants.userId ?? "", Constants.token));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenLoadingState, failure.message))
            }, (response) {
      // right -> success
      items = response.items;

      inputState.add(ContentState());

      contentInput.add(GetMyProfileAds(response.items));
    });
  }

  @override
  void removeAd(String itemId) async {
    var item = items.firstWhere((element) => element.id == itemId);
    int index = items.indexOf(item);

    items.remove(item);

    inputState.add(ContentState());

    var response =
        await _removeAdUseCase.execute(RemoveAdUseCaseInput(itemId));

    response.fold((failure) {
      // left -> failure
      inputState.add(ErrorState(
          StateRendererType.fullScreenLoadingState, failure.message));

      items.insert(index, item);

    }, (response) {
      // right -> success

      // items.removeWhere((element) => element.id == response.itemId);
    });

    inputState.add(ContentState());
  }
}

abstract class MyAdsViewModelInputs {
  Sink get contentInput;

  void getMyProfileAds();

  void removeAd(String itemId);
}

abstract class MyAdsViewModelOutputs {
  Stream<GetMyProfileAds> get contentOutput;
}
