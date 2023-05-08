import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class NewConversationUseCase
    implements BaseUseCase<NewConversationUseCaseInputs, NewConversation> {
  final Repository _repository;

  NewConversationUseCase(this._repository);

  @override
  Future<Either<Failure, NewConversation>> execute(
      NewConversationUseCaseInputs input) async {
    return await _repository
        .newConversation(NewConversation(input.senderId, input.receiverId));
  }
}

class NewConversationUseCaseInputs {
  String senderId;
  String receiverId;

  NewConversationUseCaseInputs(this.senderId, this.receiverId);
}
