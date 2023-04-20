import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class UpdateAdUseCase
    implements
        BaseUseCase<UpdateAdUseCaseInput, UpdateAd> {
  final Repository _repository;

  UpdateAdUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateAd>> execute(
      UpdateAdUseCaseInput input) async {
    return await _repository.updateAd(UpdateAdRequest(
      input.itemId,
      input.image,
      input.name,
      input.price,
      input.description,
      input.sectionId,
      input.categoryId,
      input.conditionId,
      input.token,
    ));
  }
}

class UpdateAdUseCaseInput {
  String itemId;
  String image;
  String name;
  String price;
  String description;
  int sectionId;
  int categoryId;
  int conditionId;
  String token;

  UpdateAdUseCaseInput(this.itemId,this.image, this.name, this.price,
      this.description, this.sectionId, this.categoryId, this.conditionId, this.token);
}
