import 'dart:async';

import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class ChatViewModel extends BaseViewModel
    with ChatViewModelInputs, ChatViewModelOutputs {
  final StreamController _socketStreamController =
      StreamController<String>.broadcast();

  @override
  void start() {
    connectAndListen();
  }

  @override
  void dispose() {
    _socketStreamController.close();

    super.dispose();
  }

  @override
  Sink get socketInput => _socketStreamController.sink;

  @override
  Stream<String> get socketOutput =>
      _socketStreamController.stream.map((response) => response);

  void connectAndListen() {
    IO.Socket socket = IO.io('http://192.168.1.2:9001',
        OptionBuilder().setTransports(['websocket']).build());
    socket.onConnect((_) {
      print('connect');
      socket.emit('token', 'test');
    });

    //When an event recieved from server, data is added to the stream
    socket.on('event', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.emit("event", "{0,12}00");
  }
}

abstract class ChatViewModelInputs {
  Sink get socketInput;
}

abstract class ChatViewModelOutputs {
  Stream<String> get socketOutput;
}
