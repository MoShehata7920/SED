import 'dart:async';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/notifications.dart';
import 'package:sed/presentation/base/baseviewmodel.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';

import '../../../../../app/di.dart';

class NotificationScreenViewModel extends BaseViewModel
    with NotificationScreenViewModelInputs, NotificationScreenViewModelOutputs {
  final _notificationsStreamController =
      StreamController<Notifications>.broadcast();

  final NotificationsUseCase _notificationsUseCase =
      instance<NotificationsUseCase>();

  @override
  void start() {
    getNotifications();
  }

  @override
  void dispose() {
    _notificationsStreamController.close();

    super.dispose();
  }

  @override
  Sink get notificationsInput => _notificationsStreamController.sink;

  @override
  Stream<Notifications> get notificationsOutput =>
      _notificationsStreamController.stream
          .map((notifications) => notifications);

  @override
  void getNotifications() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState));

    var response = await _notificationsUseCase.execute(null);

    response.fold(
        (failure) => {
              // left -> failure
            }, (response) {
      // right -> success
      // post data to view
      notificationsInput.add(response);
    });
  }
}

abstract class NotificationScreenViewModelInputs {
  Sink get notificationsInput;

  void getNotifications();
}

abstract class NotificationScreenViewModelOutputs {
  Stream<Notifications> get notificationsOutput;
}
