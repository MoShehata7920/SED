import 'package:dartz/dartz.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/base_usecase.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';

class GetSavedProductsUseCase
    implements BaseUseCase<void, ShowItems> {
  final Repository _repository;

  GetSavedProductsUseCase(this._repository);

  @override
  Future<Either<Failure, ShowItems>> execute(
      void input) async {
    return await _repository
        .getSavedProducts();
  }
}