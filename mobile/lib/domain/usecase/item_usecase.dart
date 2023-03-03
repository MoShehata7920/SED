import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class ItemUseCase implements BaseUseCase<int, Item> {
  final Repository _repository;

  ItemUseCase(this._repository);

  @override
  Future<Either<Failure, Item>> execute(int input) async {
    return await _repository.getItemData(input);
  }
}