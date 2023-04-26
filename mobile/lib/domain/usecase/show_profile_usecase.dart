import 'package:dartz/dartz.dart';
import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ShowProfileUseCase
    implements BaseUseCase<ShowProfileUseCaseInputs, ShowItems> {
  final Repository _repository;

  ShowProfileUseCase(this._repository);

  @override
  Future<Either<Failure, ShowItems>> execute(
      ShowProfileUseCaseInputs input) async {
    return await _repository
        .getShowProfile(ShowProfileRequest(input.profileId));
  }
}

class ShowProfileUseCaseInputs {
  String profileId;

  ShowProfileUseCaseInputs(this.profileId);
}
