import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/show_profile_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

class ShowProfileViewModel extends BaseViewModel
    with ShowProfileViewModelInputs, ShowProfileViewModelOutputs {
  final ShowProfileUseCase _profileUseCase = instance<ShowProfileUseCase>();
  List<Items> showProfileProducts = [];

  @override
  void start() {}

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void getShowProfile(int profileId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response =
        await _profileUseCase.execute(ShowProfileUseCaseInputs(profileId));

    response.fold(
        (failure) => {
              // left -> failure
              inputState.add(ErrorState(
                  StateRendererType.fullScreenLoadingState, failure.message))
            }, (response) {
      // right -> success
      showProfileProducts = response.items;

      inputState.add(ContentState());
    });
  }
}

abstract class ShowProfileViewModelInputs {
  void getShowProfile(int profileId);
}

abstract class ShowProfileViewModelOutputs {}
