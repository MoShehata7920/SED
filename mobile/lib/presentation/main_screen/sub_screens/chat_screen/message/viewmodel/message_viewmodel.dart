import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/usecase/new_conversation_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';

class MessageViewModel extends BaseViewModel
    with MessageViewModelInputs, MessageViewModelOutputs {
  final NewConversationUseCase _newConversationUseCase =
      instance<NewConversationUseCase>();

  @override
  void start() {}

  @override
  Future<String> createNewConversation(String sellerId) async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _newConversationUseCase.execute(
        NewConversationUseCaseInputs(Utils.getUserId(), sellerId));

    String conversationId = "";

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success

      conversationId = response.conversationId;

      inputState.add(ContentState());
    });

    return conversationId;
  }

}

abstract class MessageViewModelInputs {
  Future<String> createNewConversation(String sellerId);
}

abstract class MessageViewModelOutputs {}
