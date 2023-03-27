import 'package:dartz/dartz.dart';
import 'package:sed/data/network/requests.dart';
import '../../data/network/failure.dart';
import '../model/models.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ShowItemsUseCase
    implements BaseUseCase<ShowItemsUseCaseInputs, ShowItems> {
  final Repository _repository;

  ShowItemsUseCase(this._repository);

  @override
  Future<Either<Failure, ShowItems>> execute(
      ShowItemsUseCaseInputs input) async {
    return await _repository
        .getShowItems(ShowItemsRequest(input.type, input.offset));
  }
}

class ShowItemsUseCaseInputs {
  String type;
  int offset;
  ShowItemsUseCaseInputs(this.type, this.offset);
}
