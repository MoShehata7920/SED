import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class UpdateAdUseCase implements BaseUseCase<UpdateAdUseCaseInput, UpdateAd> {
  final Repository _repository;

  UpdateAdUseCase(this._repository);

  @override
  Future<Either<Failure, UpdateAd>> execute(UpdateAdUseCaseInput input) async {
    return await _repository.updateAd(UpdateAdRequest(
      input.itemId,
      input.image,
      input.name,
      input.price,
      input.description,
      input.purpose,
      input.category,
      input.condition,
      input.token,
    ));
  }
}

class UpdateAdUseCaseInput {
  String? itemId;
  File? image;
  String? name;
  int? price;
  String? description;
  String? purpose;
  String? category;
  String? condition;
  String? token;

  UpdateAdUseCaseInput(
      this.itemId,
      this.image,
      this.name,
      this.price,
      this.description,
      this.purpose,
      this.category,
      this.condition,
      this.token);
}
