import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/add_product_screen/categories/categories_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/view/chat_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/view/home_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/view/settings_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view/show_items_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';

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
    const CategoriesScreenView(),
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

  Sink get socketInput => _socketStreamController.sink;

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

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        instance<FlutterLocalNotificationsPlugin>();
  }
}

abstract class MainScreenViewModelInputs {
  Sink get mainViewInput;

  void onIndexChange(int index);
}

abstract class MainScreenViewModelOutputs {
  Stream<Widget> get mainViewOutput;
}
