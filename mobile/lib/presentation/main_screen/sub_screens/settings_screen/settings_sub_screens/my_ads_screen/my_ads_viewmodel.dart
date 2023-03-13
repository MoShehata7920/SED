import 'dart:async';

import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/myprofile_data_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class MyAdsViewModel extends BaseViewModel
    with MyAdsViewModelInputs, MyAdsViewModelOutputs {
  final StreamController _contentStreamController =
      StreamController<MyProfileDataContentObject>.broadcast();

  final MyProfileDataUseCase _myProfileDataUseCase =
      instance<MyProfileDataUseCase>();

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
  }

    @override
  Sink get contentInput => _contentStreamController.sink;

  @override
  Stream<GetMyProfileData> get contentOutput =>
      _contentStreamController.stream
          .map((myProfileData) => myProfileData);

  @override
  void getMyProfileData(String token) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _myProfileDataUseCase.execute(Constants.token);

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenLoadingState, failure.message))
            }, (response) {
      // right -> success

      inputState.add(ContentState());

      contentInput.add(GetMyProfileData(response.user));

    });
  }
}

abstract class MyAdsViewModelInputs {
  Sink get contentInput;

  void getMyProfileData(String token);
}

abstract class MyAdsViewModelOutputs {
  Stream<GetMyProfileData> get contentOutput;
}
