import 'dart:io';

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

  Future<DefaultResponse> updateUserProfile(
      UpdateUserProfileRequest updateUserProfileRequest);

  Future<DefaultResponse> changePassword(
      ChangePasswordRequest changePasswordRequest);

  Future<NotificationsResponse> notifications();

  Future<ShowItemsResponse> getSavedProducts();

  Future<SearchResponse> getSearchedProducts(String searchText);
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
    return await _appServiceClient.getHomeData("Bearer ${Constants.token}");
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
    return await _appServiceClient.toggleSavingProduct(
        savingProductRequest.productId, "Bearer ${Constants.token}");
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
      addAdvertisementRequest.purpose,
      addAdvertisementRequest.category,
      addAdvertisementRequest.condition,
      "Bearer ${Constants.token}",
    );
  }

  @override
  Future<GetMyProfileDataResponse> getMyProfileData(String token) async {
    return await _appServiceClient
        .getMyProfileData("Bearer ${Constants.token}");
  }

  @override
  Future<GetMyProfileAdsResponse> getMyProfileAds(
      GetMyProfileAdsRequest getMyProfileAdsRequest) async {
    return await _appServiceClient.getMyProfileAds(
        getMyProfileAdsRequest.sellerId, "Bearer ${Constants.token}");
  }

  @override
  Future<RemoveAdResponse> removeAd(String prodId) async {
    return await _appServiceClient.removeAd(
        prodId, "Bearer ${Constants.token}");
  }

  @override
  Future<UpdateAdResponse> updateAd(UpdateAdRequest updateAdRequest) async {
    Map<String, dynamic> map = {};

    if (updateAdRequest.name != null) map['name'] = updateAdRequest.name;
    if (updateAdRequest.price != null) map['price'] = updateAdRequest.price;
    if (updateAdRequest.description != null)
      map['description'] = updateAdRequest.description;
    if (updateAdRequest.purpose != null)
      map['purpose'] = updateAdRequest.purpose;
    if (updateAdRequest.category != null)
      map['category'] = updateAdRequest.category;
    if (updateAdRequest.condition != null)
      map['condition'] = updateAdRequest.condition;

    var result = await _appServiceClient.updateAd(
        updateAdRequest.itemId ?? "", map, "Bearer ${Constants.token}");

    if (updateAdRequest.image != null) {
      await _appServiceClient.updateProductImage(updateAdRequest.itemId ?? "",
          updateAdRequest.image ?? File(""), "Bearer ${Constants.token}");
    }

    return result;
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

  @override
  Future<ShowItemsResponse> getSavedProducts() async {
    return await _appServiceClient
        .getSavedProducts("Bearer ${Constants.token}");
  }

  @override
  Future<SearchResponse> getSearchedProducts(String searchText) async {
    return await _appServiceClient.getSearchProducts(Constants.token);
  }

  @override
  Future<DefaultResponse> updateUserProfile(
      UpdateUserProfileRequest updateUserProfileRequest) async {
    Map<String, dynamic> map = {};

    if (updateUserProfileRequest.name != null)
      map['fullName'] = updateUserProfileRequest.name;
    if (updateUserProfileRequest.phoneNumber != null)
      map['phone'] = updateUserProfileRequest.phoneNumber;
    if (updateUserProfileRequest.government != null)
      map['government'] = updateUserProfileRequest.government;
    if (updateUserProfileRequest.address != null)
      map['address'] = updateUserProfileRequest.address;

    var result = await _appServiceClient.updateUserProfile(
        updateUserProfileRequest.userId ?? "",
        map,
        "Bearer ${Constants.token}");

    if (updateUserProfileRequest.userImage != null) {
      await _appServiceClient.updateUserProfileImage(
          updateUserProfileRequest.userId ?? "",
          updateUserProfileRequest.userImage ?? File(""),
          "Bearer ${Constants.token}");
    }

    return result;
  }

  @override
  Future<DefaultResponse> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    return await _appServiceClient.changePassword(
        changePasswordRequest.userId,
        changePasswordRequest.oldPassword,
        changePasswordRequest.newPassword,
        changePasswordRequest.confirmNewPassword,
        "Bearer ${Constants.token}");
  }
}
