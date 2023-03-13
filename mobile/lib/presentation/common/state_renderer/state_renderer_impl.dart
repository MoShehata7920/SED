import 'package:flutter/material.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import '../../main_screen/utils/utils.dart';
import '../../resources/strings_manager.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();

  String getTitle();

  Function getFunction();
}

// loading state (PopUp , FullScreen)
class LoadingState extends FlowState {
  StateRendererType stateRendererType;
  String? message;
  String? title;

  LoadingState(
      {required this.stateRendererType, String message = AppStrings.loading});

  @override
  String getMessage() => message ?? AppStrings.loading;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => title ?? AppStrings.title;

  @override
  Function getFunction() => () {};
}

// Error state (PopUp , FullScreen)
class ErrorState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  String? title;

  ErrorState(this.stateRendererType, this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => title ?? AppStrings.title;

  @override
  Function getFunction() => () {};
}

// Content state
class ContentState extends FlowState {
  ContentState();

  @override
  String getMessage() => Constants.empty;

  @override
  StateRendererType getStateRendererType() => StateRendererType.contentState;

  @override
  String getTitle() => Constants.empty;

  @override
  Function getFunction() => () {};
}

// Empty state
class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.fullScreenEmptyState;

  @override
  String getTitle() => Constants.empty;

  @override
  Function getFunction() => () {};
}

class SuccessState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  String title;

  SuccessState(this.stateRendererType, this.message, this.title);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => title;

  @override
  Function getFunction() => () {};
}

class ConfirmationState extends FlowState {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function function;

  ConfirmationState(
      this.stateRendererType, this.message, this.title, this.function);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;

  @override
  String getTitle() => title;

  @override
  Function getFunction() => function;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentScreenWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        {
          if (getStateRendererType() == StateRendererType.popUpLoadingState) {
            // show PopUp loading
            showPopUp(
                context: context,
                stateRendererType: getStateRendererType(),
                message: getMessage(),function: () => (){});

            // show content UI of screen
            return contentScreenWidget;
          } else {
            Utils.isDialogShown = false;

            // full screen loading state
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }

      case ErrorState:
        {
          if (Utils.isDialogShown) {
            dismissDialog(context);
          }

          if (getStateRendererType() == StateRendererType.popUpErrorState) {
            // show PopUp error

            showPopUp(
                context: context,
                stateRendererType: getStateRendererType(),
                message: getMessage(), function: () => (){});

            // show content UI of screen
            return contentScreenWidget;
          } else {
            Utils.isDialogShown = false;

            // full screen error state
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }

      case EmptyState:
        {
          Utils.isDialogShown = false;

          return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateRendererType(),
            retryActionFunction: () {},
          );
        }

      case ContentState:
        {
          if (Utils.isDialogShown) {
            dismissDialog(context);
          }

          Utils.isDialogShown = false;

          return contentScreenWidget;
        }

      case SuccessState:
        {
          if (Utils.isDialogShown) {
            dismissDialog(context);
          }

          Utils.isDialogShown = false;

          showPopUp(
              context: context,
              stateRendererType: getStateRendererType(),
              message: getMessage(),
              title: getTitle(), function: () => (){});

          return contentScreenWidget;
        }

      case ConfirmationState:
        {
          if (getStateRendererType() ==
              StateRendererType.popUpConfirmationState) {
            // show PopUp loading
            showPopUp(
                context: context,
                stateRendererType: getStateRendererType(),
                message: getMessage(),function: getFunction());

            // show content UI of screen
            return contentScreenWidget;
          } else {
            Utils.isDialogShown = false;

            // full screen loading state
            return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction,
            );
          }
        }

      default:
        {
          dismissDialog(context);

          return contentScreenWidget;
        }
    }
  }

  showPopUp(
      {required BuildContext context,
      required StateRendererType stateRendererType,
      required String message,
      String title = "",required Function function}) {
    WidgetsBinding.instance.addPostFrameCallback((_) => showDialog(
          context: context,
          builder: (BuildContext context) => StateRenderer(
            stateRendererType: stateRendererType,
            retryActionFunction: function,
            message: message,
            title: title,
          ),
        ));
  }

  // to check if there is any dialog on screen
  _isCurrentDialogShown(BuildContext context) =>
      ModalRoute.of(context) != null &&
      ModalRoute.of(context)!.isActive &&
      ModalRoute.of(context)?.isCurrent != true;

  // to remove old dialog which is opened before showing the new one
  dismissDialog(BuildContext context) {
    if (_isCurrentDialogShown(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }
}
