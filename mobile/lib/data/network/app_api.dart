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

  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("user_name") String userName,
    @Field("country_mobile_code") String countryMobileCode,
    @Field("mobile_number") String mobileNumber,
    @Field("email") String email,
    @Field("password") String password,
  );

  @GET("/home/")
  Future<HomeResponse> getHomeData(
    @Header("token") String token,
  );

  @GET("/Items/{itemId}")
  Future<ItemResponse> getItemData(
    @Path("itemId") int itemId,
  );

  @GET("/home/{type}/{pageId}")
  Future<ShowItemsResponse> getShowItemsData(
    @Path("type") String? type,
    @Path("pageId") int? offset,);

  @GET("/Products/{itemId}")
  Future<SavingProductResponse> toggleSavingProduct(
    @Path("itemId") int itemId,
  );

  @GET("/Profile/{profileId}")
  Future<ShowItemsResponse> getShowProfileData(
    @Path("profileId") int profileId,
  );

  @POST("/customers/AddAdvertisement")
  Future<AddAdvertisementResponse> addAdvertisement(
      @Field("image") String image,
      @Field("name") String name,
      @Field("price") String price,
      @Field("description") String description,
      @Field("sectionId") int sectionId,
      @Field("categoryId") int categoryId,
      @Field("conditionId") int conditionId,
      @Header("Authorization") String token);

  @GET("/MyProfile")
  Future<GetMyProfileDataResponse> getMyProfileData(
      @Header("Authorization") String token);

  @GET("/MyProfile/Ads/{pageId}")
  Future<GetMyProfileAdsResponse> getMyProfileAds(
      @Path("pageId") int pageId, @Header("Authorization") String contentType);

  @POST("/MyProfile/DeleteAd")
  Future<RemoveAdResponse> removeAd(
      @Field("itemId") int itemId, @Header("token") String token);

  @POST("/MyProfile/UpdateAd")
  Future<UpdateAdResponse> updateAd(
    @Field("itemId") int itemId,
    @Header("token") String token,
    @Field("image") String image,
    @Field("name") String name,
    @Field("price") String price,
    @Field("description") String description,
    @Field("sectionId") int sectionId,
    @Field("categoryId") int categoryId,
    @Field("conditionId") int conditionId,
  );

  @GET("/Notifications")
  Future<NotificationsResponse> notifications(
    @Header("token") String token,
  );
}
