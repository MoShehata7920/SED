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

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
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
}
