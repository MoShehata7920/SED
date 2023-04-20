import 'package:sed/app/constants.dart';
import 'package:sed/data/network/app_api.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/data/responses/responses.dart';
import 'package:sed/domain/model/models.dart';

abstract class RemoteDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<ForgotPasswordResponse> forgotPassword(String email);

  Future<VerifyEmailResponse> verifyEmail(int code);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<HomeResponse> getHomeData();

  Future<ItemResponse> getProductData(String productId);

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

  Future<RemoveAdResponse> removeAd(String itemId);

  Future<UpdateAdResponse> updateAd(UpdateAdRequest updateAdRequest);

  Future<NotificationsResponse> notifications();
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
        registerRequest.mobileNumber,
        registerRequest.email,
        registerRequest.password,
        registerRequest.confirmPassword);
  }

  @override
  Future<HomeResponse> getHomeData() async {
    return await _appServiceClient.getHomeData(Constants.token);
  }

  @override
  Future<ItemResponse> getProductData(String productId) async {
    return await _appServiceClient.getProductData(productId);
  }

  @override
  Future<ShowItemsResponse> getShowItemsData(
      ShowItemsRequest showItemsRequest) async {
    return await _appServiceClient.getShowItemsData(showItemsRequest.purpose,
        showItemsRequest.category, showItemsRequest.page);
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
      addAdvertisementRequest.conditionId,
      addAdvertisementRequest.token,
    );
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
  Future<RemoveAdResponse> removeAd(String itemId) async {
    return await _appServiceClient.removeAd(itemId, Constants.token);
  }

  @override
  Future<UpdateAdResponse> updateAd(UpdateAdRequest updateAdRequest) async {
    return await _appServiceClient.updateAd(
        updateAdRequest.itemId,
        updateAdRequest.token,
        updateAdRequest.image,
        updateAdRequest.name,
        updateAdRequest.price,
        updateAdRequest.description,
        updateAdRequest.sectionId,
        updateAdRequest.categoryId,
        updateAdRequest.conditionId);
  }

  @override
  Future<NotificationsResponse> notifications() async {
    return await _appServiceClient.notifications(Constants.token);
  }

  @override
  Future<VerifyEmailResponse> verifyEmail(int code) async {
    return await _appServiceClient.verifyEmail(
        code, "Bearer ${Constants.token}");
  }
}
