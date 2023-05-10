import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class NewMessageUseCase
    implements BaseUseCase<NewMessageUseCaseInput, NewMessage> {
  final Repository _repository;

  NewMessageUseCase(this._repository);

  @override
  Future<Either<Failure, NewMessage>> execute(
      NewMessageUseCaseInput input) async {
    return await _repository.newMessage(NewMessageRequest(
      input.conversationId,
      input.senderId,
      input.text
    ));
  }
}

class NewMessageUseCaseInput {
  String conversationId;
  String senderId;
  String text;

  NewMessageUseCaseInput(
      this.conversationId,
      this.senderId,
      this.text
      );
}
