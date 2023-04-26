import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class RemoveAdUseCase implements BaseUseCase<RemoveAdUseCaseInput, RemoveAd> {
  final Repository _repository;

  RemoveAdUseCase(this._repository);

  @override
  Future<Either<Failure, RemoveAd>> execute(RemoveAdUseCaseInput input) async {
    return await _repository.removeAd(RemoveAdRequest(
      input.itemId,
    ));
  }
}

class RemoveAdUseCaseInput {
  String itemId;

  RemoveAdUseCaseInput(this.itemId);
}
