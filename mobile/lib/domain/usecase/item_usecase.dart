import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class ProductUseCase implements BaseUseCase<String, Item> {
  final Repository _repository;

  ProductUseCase(this._repository);

  @override
  Future<Either<Failure, Item>> execute(String input) async {
    return await _repository.getProductData(input);
  }
}