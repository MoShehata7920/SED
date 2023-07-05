import 'dart:async';
import 'package:sed/app/di.dart';
import 'package:sed/domain/usecase/get_all_conversations_usecase.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../../../../domain/model/models.dart';

class ChatViewModel extends BaseViewModel
    with ChatViewModelInputs, ChatViewModelOutputs {
  final StreamController _socketStreamController =
      StreamController<Messages>.broadcast();

  final GetAllConversationsUseCase _newConversationUseCase =
      instance<GetAllConversationsUseCase>();

  late io.Socket socket;

  GetAllConversations conversations = GetAllConversations([]);
  @override
  void start() {
    connectAndListen();
  }


  @override
  Sink get socketInput => _socketStreamController.sink;

  @override
  Stream<Messages> get socketOutput =>
      _socketStreamController.stream.map((response) => response);

  void connectAndListen() {
    // socket = io.io('http://47.243.7.214:3000',
    //     OptionBuilder().setTransports(['websocket']).build());
    //
    // socket.onConnect((_) {
    //   final userId = Utils.getUserId();
    //   print('User ID is $userId');
    //   socket.emit('saveUserData', {'id': userId});
    // });
    //
    // socket.onDisconnect((_) => print('disconnect'));
    //
    // socket.on('messageReceived', (data) {
    //   Messages msg = Messages(data['conversation'], data['sender']['_id'], data['text'], data['createdAt']);
    //
    //   print(data);
    //   socketInput.add(msg);
    // });
  }

  @override
  void getAllConversations() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _newConversationUseCase
        .execute(GetAllConversationsUseCaseInput(Utils.getUserId()));

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success
      conversations = response;

      inputState.add(ContentState());
    });
  }
}

abstract class ChatViewModelInputs {
  Sink get socketInput;

  void getAllConversations();
}

abstract class ChatViewModelOutputs {
  Stream<Messages> get socketOutput;
}
