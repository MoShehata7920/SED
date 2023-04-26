import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class SearchUseCase implements BaseUseCase<String, ShowItems> {
  final Repository _repository;

  SearchUseCase(this._repository);

  @override
  Future<Either<Failure, ShowItems>> execute(String input) async {
    return await _repository.getSearchedProducts(input);
  }
}
