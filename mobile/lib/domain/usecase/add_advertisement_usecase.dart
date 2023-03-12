import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';


class AddAdvertisementUseCase
    implements
        BaseUseCase<AddAdvertisementUseCaseUseCaseInput, AddAdvertisement> {
  final Repository _repository;

  AddAdvertisementUseCase(this._repository);

  @override
  Future<Either<Failure, AddAdvertisement>> execute(
      AddAdvertisementUseCaseUseCaseInput input) async {
    return await _repository.addAdvertisement(AddAdvertisementRequest(
      input.image,
      input.name,
      input.price,
      input.description,
      input.sectionId,
      input.categoryId,
      input.conditionId,
    ));
  }
}

class AddAdvertisementUseCaseUseCaseInput {
  String image;
  String name;
  String price;
  String description;
  int sectionId;
  int categoryId;
  int conditionId;

  AddAdvertisementUseCaseUseCaseInput(this.image, this.name, this.price,
      this.description, this.sectionId, this.categoryId, this.conditionId);
}
