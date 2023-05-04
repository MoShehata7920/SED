import 'dart:async';

import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../../../domain/usecase/myprofile_data_usecase.dart';

class SettingsScreenViewModel extends BaseViewModel
    with SettingsScreenViewModelInputs, SettingsScreenViewModelOutputs {
  final StreamController _contentStreamController =
      StreamController<GetMyProfileData>.broadcast();

  final MyProfileDataUseCase _myProfileDataUseCase =
      instance<MyProfileDataUseCase>();

  @override
  void start() {
    getMyProfileData();
  }

  @override
  void dispose() {
    _contentStreamController.close();

    super.dispose();
  }

  @override
  Sink get contentInput => _contentStreamController.sink;

  @override
  Stream<GetMyProfileData> get contentOutput =>
      _contentStreamController.stream.map((myProfileData) => myProfileData);

  @override
  void getMyProfileData() async {
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

      contentInput.add(GetMyProfileData(response.user));

      Constants.userId = response.user.id;

      inputState.add(ContentState());

    });
  }
}

abstract class SettingsScreenViewModelOutputs {
  Sink get contentInput;

  void getMyProfileData();
}

abstract class SettingsScreenViewModelInputs {
  Stream<GetMyProfileData> get contentOutput;
}
