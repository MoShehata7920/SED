import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

import '../repository/repository.dart';

class MyProfileAdsUseCase implements BaseUseCase<GetMyProfileAdsInput, GetMyProfileAds> {
  final Repository _repository;

  MyProfileAdsUseCase(this._repository);

  @override
  Future<Either<Failure, GetMyProfileAds>> execute(
      GetMyProfileAdsInput getMyProfileAdsInput) async {
    return await _repository.getMyProfileAds(GetMyProfileAdsRequest(
        getMyProfileAdsInput.sellerId, getMyProfileAdsInput.token));
  }
}

class GetMyProfileAdsInput {
  String sellerId;
  String token;

  GetMyProfileAdsInput(this.sellerId, this.token);
}
