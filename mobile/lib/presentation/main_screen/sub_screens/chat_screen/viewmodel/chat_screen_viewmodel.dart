import 'package:sed/presentation/base/baseviewmodel.dart';

class ChatViewModel extends BaseViewModel
    with ChatViewModelInputs, ChatViewModelOutputs {
  @override
  void start() {
    // TODO: implement start
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

abstract class ChatViewModelInputs {}

abstract class ChatViewModelOutputs {}
