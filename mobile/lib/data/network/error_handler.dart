// ignore_for_file: constant_identifier_names, non_constant_identifier_names

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioError) {
      // dio error so its an error from response of the API or from Dio itself
      failure = _handleError(error);
    } else {
      // default error
      failure = DataSource.DEFAULT.getFailure();
    }
  }
}

Failure _handleError(DioError error) {
  switch (error.type) {
    case DioErrorType.connectTimeout:
      return DataSource.CONNECTION_TIMEOUT.getFailure();

    case DioErrorType.sendTimeout:
      return DataSource.SEND_TIMEOUT.getFailure();

    case DioErrorType.receiveTimeout:
      return DataSource.RECEIVE_TIMEOUT.getFailure();

    case DioErrorType.response:
      if (error.response != null &&
          error.response?.statusMessage != null &&
          error.response?.statusCode != null) {
        return Failure(error.response?.statusCode ?? 0,
            error.response?.statusMessage ?? "");
      } else {
        return DataSource.DEFAULT.getFailure();
      }

    case DioErrorType.cancel:
      return DataSource.CANCEL.getFailure();

    case DioErrorType.other:
      return DataSource.DEFAULT.getFailure();
  }
}

enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUTHORIZED,
  NOT_FOUND,
  INTERNAL_SERVER_ERROR,
  CONNECTION_TIMEOUT,
  CANCEL,
  RECEIVE_TIMEOUT,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION,
  DEFAULT,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.SUCCESS:
        return Failure(ResponseCode.SUCCESS, ResponseMessage.SUCCESS);

      case DataSource.NO_CONTENT:
        return Failure(ResponseCode.NO_CONTENT, ResponseMessage.NO_CONTENT);

      case DataSource.BAD_REQUEST:
        return Failure(ResponseCode.BAD_REQUEST, ResponseMessage.BAD_REQUEST);

      case DataSource.FORBIDDEN:
        return Failure(ResponseCode.FORBIDDEN, ResponseMessage.FORBIDDEN);

      case DataSource.UNAUTHORIZED:
        return Failure(ResponseCode.UNAUTHORIZED, ResponseMessage.UNAUTHORIZED);

      case DataSource.NOT_FOUND:
        return Failure(ResponseCode.NOT_FOUND, ResponseMessage.NOT_FOUND);

      case DataSource.INTERNAL_SERVER_ERROR:
        return Failure(ResponseCode.INTERNAL_SERVER_ERROR,
            ResponseMessage.INTERNAL_SERVER_ERROR);

      case DataSource.CONNECTION_TIMEOUT:
        return Failure(
            ResponseCode.CONNECTION_TIMEOUT, ResponseMessage.CONNECT_TIMEOUT);

      case DataSource.CANCEL:
        return Failure(ResponseCode.CANCEL, ResponseMessage.CANCEL);

      case DataSource.RECEIVE_TIMEOUT:
        return Failure(
            ResponseCode.RECEIVE_TIMEOUT, ResponseMessage.RECEIVE_TIMEOUT);

      case DataSource.SEND_TIMEOUT:
        return Failure(ResponseCode.SEND_TIMEOUT, ResponseMessage.SEND_TIMEOUT);

      case DataSource.CACHE_ERROR:
        return Failure(ResponseCode.CACHE_ERROR, ResponseMessage.CACHE_ERROR);

      case DataSource.NO_INTERNET_CONNECTION:
        return Failure(ResponseCode.NO_INTERNET_CONNECTION,
            ResponseMessage.NO_INTERNET_CONNECTION);

      case DataSource.DEFAULT:
        return Failure(ResponseCode.DEFAULT, ResponseMessage.DEFAULT);
    }
  }
}

class ResponseCode {
  static const int SUCCESS = 200; //success with data
  static const int NO_CONTENT = 201; //success with no data
  static const int BAD_REQUEST = 400; //failure, API rejected request
  static const int UNAUTHORIZED = 401; //failure, user is not authorized
  static const int FORBIDDEN = 403; //failure, API rejected request
  static const int NOT_FOUND = 404; // failure, not found
  static const int INTERNAL_SERVER_ERROR = 500; //failure, crash in server side

  //local status code
  static const int CONNECTION_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECEIVE_TIMEOUT = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int DEFAULT = -7;
}

class ResponseMessage {
  static String SUCCESS = AppStrings.success.tr(); // success with data
  static String NO_CONTENT =
      AppStrings.success.tr(); // success with no data (no content)
  static String BAD_REQUEST =
      AppStrings.badRequest.tr(); // failure, API rejected request
  static String UNAUTHORIZED =
      AppStrings.unAuthorized.tr(); // failure, user is not authorized
  static String FORBIDDEN =
      AppStrings.forbidden.tr(); //  failure, API rejected request
  static String INTERNAL_SERVER_ERROR =
      AppStrings.somethingWrong.tr(); // failure, crash in server side
  static String NOT_FOUND =
      AppStrings.somethingWrong.tr(); // failure, data not found

  // local status code
  static String CONNECT_TIMEOUT = AppStrings.timeOut.tr();
  static String CANCEL = AppStrings.cancelRequest.tr();
  static String RECEIVE_TIMEOUT = AppStrings.timeOut.tr();
  static String SEND_TIMEOUT = AppStrings.timeOut.tr();
  static String CACHE_ERROR = AppStrings.cacheError.tr();
  static String NO_INTERNET_CONNECTION = AppStrings.noInternet.tr();
  static String DEFAULT = AppStrings.somethingWrong.tr();
}

class ApiInternalStatus {
  static const int SUCCESS = 0;
  static const int FAILURE = 1;
}
