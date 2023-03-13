import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class MyProfileDataUseCase
    implements BaseUseCase<String, GetMyProfileData> {
  final Repository _repository;

  MyProfileDataUseCase(this._repository);

  @override
  Future<Either<Failure, GetMyProfileData>> execute(
      String token) async {
    return await _repository.getMyProfileData(token);
  }
}