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
    @Header("Authentication") String token,
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
    @Path("profileId") String profileId,
  );

  @PATCH("/users/update/{userId}")
  Future<DefaultResponse> updateUserProfile(
    @Path("userId") String userId,
    @Body() Map<String, dynamic> map,
    @Header("Authentication") String token,
  );

  @MultiPart()
  @PATCH("/users/update/{userId}")
  Future<AddAdvertisementResponse> updateUserProfileImage(
      @Path("userId") String userId,
      @Part(name: "userImage") File image,
      @Header("Authentication") String token);

  @PATCH("/users/change-password/{userId}")
  Future<DefaultResponse> changePassword(
      @Path("userId") String userId,
      @Field("oldPassword") String oldPassword,
      @Field("password") String newPassword,
      @Field("confirmPassword") String confirmNewPassword,
      @Header("Authentication") String token);

  @MultiPart()
  @POST("/products/newproduct")
  Future<AddAdvertisementResponse> addAdvertisement(
      @Part(name: "productImage") File image,
      @Part(name: "productName") String name,
      @Part(name: "price") int price,
      @Part(name: "description") String description,
      @Part(name: "purpose") String purpose,
      @Part(name: "category") String category,
      @Part(name: "condition") String condition,
      @Header("Authentication") String token);

  @GET("/users/get")
  Future<GetMyProfileDataResponse> getMyProfileData(
      @Header("Authentication") String token);

  //todo change getmyprofileads to getSellerAdsById
  @GET("/products/seller/{sellerId}")
  Future<GetMyProfileAdsResponse> getMyProfileAds(
      @Path("sellerId") String sellerId,
      @Header("Authentication") String token);

  @DELETE("/products/product/{prodId}")
  Future<RemoveAdResponse> removeAd(
      @Path("prodId") String prodId, @Header("Authentication") String token);

  @PATCH("/products/product/{prodId}")
  Future<UpdateAdResponse> updateAd(
    @Path("prodId") String prodId,
    @Body() Map<String, dynamic> map,
    @Header("Authentication") String token,
  );

  @MultiPart()
  @PATCH("/products/product/{prodId}")
  Future<AddAdvertisementResponse> updateProductImage(
      @Path("prodId") String prodId,
      @Part(name: "productImage") File image,
      @Header("Authentication") String token);

  @GET("/Notifications")
  Future<NotificationsResponse> notifications(
    @Header("token") String token,
  );

  @POST("/products/search")
  Future<SearchResponse> getSearchProducts(
    @Header("token") String token,
  );

  // chat
  @POST("/chat/new-conversation")
  Future<NewConversationResponse> openNewConversation(
    @Field("senderId") String senderId,
    @Field("receiverId") String receiverId,
  );

  @GET("/chat/user-convs/{userId}")
  Future<GetAllConversationsResponse> getAllConversations(
    @Path("userId") String userId,
  );
}
