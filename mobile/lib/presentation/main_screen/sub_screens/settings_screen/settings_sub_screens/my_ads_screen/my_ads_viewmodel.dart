import 'dart:async';

import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/myprofile_data_usecase.dart';
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

  @override
  void start() {
    inputState.add(ContentState());

    getMyProfileAds();
  }

  @override
  void dispose() {
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
        .execute(GetMyProfileAdsInput(0, Constants.token));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenLoadingState, failure.message))
            }, (response) {
      // right -> success

      inputState.add(ContentState());

      contentInput.add(GetMyProfileAds(response.items));
    });
  }
}

abstract class MyAdsViewModelInputs {
  Sink get contentInput;

  void getMyProfileAds();
}

abstract class MyAdsViewModelOutputs {
  Stream<GetMyProfileAds> get contentOutput;
}
