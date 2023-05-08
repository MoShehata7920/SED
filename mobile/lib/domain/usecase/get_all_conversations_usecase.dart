import 'package:dartz/dartz.dart';
import 'package:sed/data/network/requests.dart';
import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class GetAllConversationsUseCase
    implements BaseUseCase<GetAllConversationsUseCaseInput, GetAllConversations> {
  final Repository _repository;

  GetAllConversationsUseCase(this._repository);

  @override
  Future<Either<Failure, GetAllConversations>> execute(
      GetAllConversationsUseCaseInput input) async {
    return await _repository
        .getAllConversations(GetAllConversationsRequest(input.userId));
  }
}

class GetAllConversationsUseCaseInput {
  String userId;

  GetAllConversationsUseCaseInput(this.userId);
}
