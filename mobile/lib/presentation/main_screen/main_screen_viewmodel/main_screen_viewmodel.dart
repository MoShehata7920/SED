import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/noti.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/view/chat_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/view/home_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/view/settings_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view/show_items_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MainScreenViewModel extends BaseViewModel
    with MainScreenViewModelInputs, MainScreenViewModelOutputs {
  final StreamController _mainViewStreamController =
      StreamController<int>.broadcast();

  int bottomNavIndex = 0;

  final StreamController _socketStreamController =
  StreamController<String>.broadcast();

  final List<Widget> mainScreenWidgets = [
    const HomeScreenView(),
    const ChatScreenView(),
    ShowItemsView(Views.SAVED),
    const SettingsScreenView(),
  ];
  // Inputs
  @override
  void start() {
    connectAndListen();
  }

  @override
  void dispose() {
    _socketStreamController.close();

    _mainViewStreamController.close();

    super.dispose();
  }

  @override
  Sink get socketInput => _socketStreamController.sink;

  @override
  Stream<String> get socketOutput =>
      _socketStreamController.stream.map((response) => response);

  @override
  Sink get mainViewInput => _mainViewStreamController.sink;

  // Outputs
  @override
  Stream<Widget> get mainViewOutput => _mainViewStreamController.stream
      .map((index) => (mainScreenWidgets[index]));

  // Functions
  @override
  void onIndexChange(int index) {
    bottomNavIndex = index;

    mainViewInput.add(index);
  }

  Future<void> connectAndListen() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print('Device Token: $token');

    Constants.socket.onConnect((_) {
      Constants.socket.emit('token', Constants.token);
      Constants.socket.emit('tokenDevice', token);
    });

    //When an event recieved from server, data is added to the stream
    Constants.socket.on('event', (data) => print(data));
    Constants.socket.onDisconnect((_) => print('disconnect'));
    Constants.socket.emit("event", "{0,12}00");

    Constants.socket.on('message', (data) => socketInput.add(data));
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = instance<FlutterLocalNotificationsPlugin>();

  }
}

abstract class MainScreenViewModelInputs {
  Sink get mainViewInput;

  void onIndexChange(int index);
}

abstract class MainScreenViewModelOutputs {
  Stream<Widget> get mainViewOutput;
}
