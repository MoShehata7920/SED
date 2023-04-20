import 'package:dartz/dartz.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/base_usecase.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';

class SavingProductsUseCase
    implements BaseUseCase<SavingProductUseCaseInputs, SavingProduct> {
  final Repository _repository;

  SavingProductsUseCase(this._repository);

  @override
  Future<Either<Failure, SavingProduct>> execute(
      SavingProductUseCaseInputs input) async {
    return await _repository
        .toggleSavingProduct(SavingProductRequest(input.productId));
  }
}

class SavingProductUseCaseInputs {
  String productId;

  SavingProductUseCaseInputs(this.productId);
}
