import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:sed/app/constants.dart';
import 'package:sed/data/responses/responses.dart';

part 'app_api.g.dart';


//Retrofit plugin is used to generate the files while dio is used to connect to the api
@RestApi(baseUrl: Constants.baseUrl) //retrofit dependency
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient; //dio dependency

  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email ,
    @Field("password") String password ,
  );
}
