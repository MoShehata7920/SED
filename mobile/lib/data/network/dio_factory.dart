// ignore_for_file: constant_identifier_names

import 'package:dio/dio.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/constants.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  final AppPreferences _appPreferences;
  DioFactory(this._appPreferences);

  Future<Dio> getDio() async {
    Dio dio = Dio();

    String language = await _appPreferences.getAppLanguage();

    Constants.token = await _appPreferences.getToken();

    // it will accept Json data
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constants.token,
      DEFAULT_LANGUAGE: language,
    };

    dio.options = BaseOptions(
        baseUrl: Constants.baseUrl,
        headers: headers,
        receiveTimeout: Constants.apiTimeOut,
        sendTimeout: Constants.apiTimeOut);

    // if (!kReleaseMode) {
    //   //debug mode
    //   dio.interceptors.add(PrettyDioLogger(
    //       requestHeader: true, requestBody: true, responseHeader: true));
    // }

    return dio;
  }
}
