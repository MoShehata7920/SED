import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

enum StateRendererType {
  // PopUp state
  popUpLoadingState,
  popUpErrorState,

  // Full screen state
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,

  // general
  contentState,
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer(
      {required this.stateRendererType,
      this.message = AppStrings.loading,
      this.title = "",
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
