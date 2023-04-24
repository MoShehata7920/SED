import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/data/responses/responses.dart';

part 'app_api.g.dart';

//Retrofit plugin is used to generate the files while dio is used to connect to the api
@RestApi(baseUrl: Constants.baseUrl) //retrofit dependency
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) =
      _AppServiceClient; //dio dependency

  @POST("/auth/login")
  Future<AuthenticationResponse> login(
    @Field("loginOption") String email,
    @Field("password") String password,
  );

  @POST("/customers/forgotPassword")
  Future<ForgotPasswordResponse> forgotPassword(
    @Field("email") String email,
  );

  @POST("/auth/register")
  Future<AuthenticationResponse> register(
    @Field("fullName") String userName,
    @Field("phone") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
    @Field("confirmPassword") String confirmPassword,
  );

  @POST("/auth/verifyemail")
  Future<VerifyEmailResponse> verifyEmail(
      @Field("code") int code, @Header("Authentication") String token);

  @GET("/home/")
  Future<HomeResponse> getHomeData(
    @Header("token") String token,
  );

  @GET("/products/product/{productId}")
  Future<ItemResponse> getProductData(
    @Path("productId") String productId,
  );

  @GET("/products/get")
  Future<ShowItemsResponse> getShowItemsData(
    @Query("purpose") String purpose,
    @Query("category") String category,
    @Query("page") int? page,
  );

  @PATCH("/users/addToWishlist")
  Future<SavingProductResponse> toggleSavingProduct(
      @Field("prodId") String productId,
      @Header("Authentication") String token);

  @GET("/users/getWishlist")
  Future<ShowItemsResponse> getSavedProducts(
      @Header("Authentication") String token);

  @GET("/Profile/{profileId}")
  Future<ShowItemsResponse> getShowProfileData(
    @Path("profileId") int profileId,
  );
  
  @POST("/products/newproduct")
  Future<AddAdvertisementResponse> addAdvertisement(
      @Part() File image,
      @Field("productName") String name,
      @Field("price") int price,
      @Field("description") String description,
      @Field("purpose") String purpose,
      @Field("category") String category,
      @Field("condition") String condition,
      @Header("Authentication") String token);

  @GET("/get")
  Future<GetMyProfileDataResponse> getMyProfileData(
      @Header("Authentication") String token);

  @GET("/MyProfile/Ads/{pageId}")
  Future<GetMyProfileAdsResponse> getMyProfileAds(
      @Path("pageId") int pageId, @Header("Authorization") String contentType);

  @POST("/MyProfile/DeleteAd")
  Future<RemoveAdResponse> removeAd(
      @Field("itemId") String itemId, @Header("token") String token);

  @POST("/MyProfile/UpdateAd")
  Future<UpdateAdResponse> updateAd(
    @Field("itemId") String itemId,
    @Header("token") String token,
    @Part() File image,
    @Field("name") String name,
    @Field("price") int price,
    @Field("description") String description,
    @Field("purpose") String purpose,
    @Field("category") String category,
    @Field("condition") String condition,
  );

  @GET("/Notifications")
  Future<NotificationsResponse> notifications(
    @Header("token") String token,
  );

  @POST("/products/search")
  Future<SearchResponse> getSearchProducts(
    @Header("token") String token,
  );
}
