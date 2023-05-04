import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class UpdateProfileUseCase
    implements BaseUseCase<UpdateUserProfileUseCaseInput, Default> {
  final Repository _repository;

  UpdateProfileUseCase(this._repository);

  @override
  Future<Either<Failure, Default>> execute(
      UpdateUserProfileUseCaseInput input) async {
    return await _repository.updateUserProfile(UpdateUserProfileRequest(
      input.userId,
      input.userImage,
      input.name,
      input.phoneNumber,
      input.government,
      input.address,
    ));
  }
}

class UpdateUserProfileUseCaseInput {
  String? userId;
  File? userImage;
  String? name;
  String? phoneNumber;
  String? government;
  String? address;

  UpdateUserProfileUseCaseInput(
    this.userId,
    this.userImage,
    this.name,
    this.phoneNumber,
    this.government,
    this.address
  );
}
