import 'package:sed/app/constants.dart';
import 'package:sed/data/network/app_api.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/data/responses/responses.dart';
import 'package:sed/domain/model/models.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<HomeResponse> getHomeData();

  Future<ItemResponse> getItemData(int itemId);

  Future<ShowItemsResponse> getShowItemsData(ShowItemsRequest showItemsRequest);

  Future<ShowItemsResponse> getShowProfile(
      ShowProfileRequest showProfileRequest);

  Future<SavingProductResponse> toggleSavingProduct(
      SavingProductRequest savingProductRequest);

  Future<AddAdvertisementResponse> addAdvertisement(
      AddAdvertisementRequest addAdvertisementRequest);

  Future<GetMyProfileDataResponse> getMyProfileData(String token);

  Future<GetMyProfileAdsResponse> getMyProfileAds(
      GetMyProfileAdsRequest getMyProfileAdsRequest);

  Future<RemoveAdResponse> removeAd(int itemId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final AppServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
        loginRequest.email, loginRequest.password);
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(String email) async {
    return await _appServiceClient.forgotPassword(email);
  }

  @override
  Future<AuthenticationResponse> register(
      RegisterRequest registerRequest) async {
    return await _appServiceClient.register(
        registerRequest.userName,
        registerRequest.countryMobileCode,
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password);
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHomeData();
  }

  @override
  Future<ItemResponse> getItemData(int itemId) async {
    return await _appServiceClient.getItemData(itemId);
  }

  @override
  Future<ShowItemsResponse> getShowItemsData(
      ShowItemsRequest showItemsRequest) async {
    return await _appServiceClient.getShowItemsData(
        showItemsRequest.type, showItemsRequest.offset);
  }

  @override
  Future<SavingProductResponse> toggleSavingProduct(
      SavingProductRequest savingProductRequest) async {
    return await _appServiceClient
        .toggleSavingProduct(savingProductRequest.productId);
  }

  @override
  Future<ShowItemsResponse> getShowProfile(
      ShowProfileRequest showProfileRequest) async {
    return await _appServiceClient
        .getShowProfileData(showProfileRequest.profileId);
  }

  @override
  Future<AddAdvertisementResponse> addAdvertisement(
      AddAdvertisementRequest addAdvertisementRequest) async {
    return await _appServiceClient.addAdvertisement(
        addAdvertisementRequest.image,
        addAdvertisementRequest.name,
        addAdvertisementRequest.price,
        addAdvertisementRequest.description,
        addAdvertisementRequest.sectionId,
        addAdvertisementRequest.categoryId,
        addAdvertisementRequest.conditionId);
  }

  @override
  Future<GetMyProfileDataResponse> getMyProfileData(String token) async {
    return await _appServiceClient.getMyProfileData(token);
  }

  @override
  Future<GetMyProfileAdsResponse> getMyProfileAds(
      GetMyProfileAdsRequest getMyProfileAdsRequest) async {
    return await _appServiceClient.getMyProfileAds(
        getMyProfileAdsRequest.pageId, getMyProfileAdsRequest.token);
  }

  @override
  Future<RemoveAdResponse> removeAd(int itemId) async {
    return await _appServiceClient.removeAd(itemId, Constants.token);
  }
}
