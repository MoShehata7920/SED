import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';

abstract class Repository {
  //* why do we pass a class instead of two strings params
  //* why failure at data layer and login request at domain layer
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, String>> forgotPassword(String email);

  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest);

  Future<Either<Failure, Home>> getHomeData();

  Future<Either<Failure, Item>> getItemData(int itemId);

  Future<Either<Failure, ShowItems>> getShowItems(
      ShowItemsRequest showItemsRequest);

  Future<Either<Failure, ShowItems>> getShowProfile(
      ShowProfileRequest showProfileRequest);

  Future<Either<Failure, SavingProduct>> toggleSavingProduct(
      SavingProductRequest savingProductRequest);

  Future<Either<Failure, AddAdvertisement>> addAdvertisement(
      AddAdvertisementRequest addAdvertisementRequest);

  Future<Either<Failure, GetMyProfileData>> getMyProfileData(String token);

  Future<Either<Failure, GetMyProfileAds>> getMyProfileAds(
      GetMyProfileAdsRequest getMyProfileAdsRequest);

  Future<Either<Failure, RemoveAd>> removeAd(RemoveAdRequest removeAdRequest);

  Future<Either<Failure, UpdateAd>> updateAd(UpdateAdRequest updateAdRequest);

  Future<Either<Failure, Notifications>> notifications();
}
