import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
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

  final List<Widget> mainScreenWidgets = [
    const HomeScreenView(),
    const ChatScreenView(),
    ShowItemsView(Views.SAVED),
    const SettingsScreenView(),
  ];
  // Inputs
  @override
  void start() {}

  @override
  void dispose() {
    _mainViewStreamController.close();
    super.dispose();
  }

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
}

abstract class MainScreenViewModelInputs {
  Sink get mainViewInput;

  void onIndexChange(int index);
}

abstract class MainScreenViewModelOutputs {
  Stream<Widget> get mainViewOutput;
}
