import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class ChatMessagesUseCase
    implements BaseUseCase<ChatMessageUseCaseInput, GetChatMessages> {
  final Repository _repository;

  ChatMessagesUseCase(this._repository);

  @override
  Future<Either<Failure, GetChatMessages>> execute(
      ChatMessageUseCaseInput input) async {
    return await _repository.getChatMessages(ChatMessagesRequest(
      input.conversationId,
    ));
  }
}

class ChatMessageUseCaseInput {
  String conversationId;

  ChatMessageUseCaseInput(
    this.conversationId,
  );
}
