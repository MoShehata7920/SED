// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_api.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AppServiceClient implements AppServiceClient {
  _AppServiceClient(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://103.48.193.225:3000';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AuthenticationResponse> login(
    email,
    password,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'loginOption': email,
      'password': password,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/auth/login',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ForgotPasswordResponse> forgotPassword(email) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'email': email};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<ForgotPasswordResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/customers/forgotPassword',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ForgotPasswordResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AuthenticationResponse> register(
    userName,
    mobileNumber,
    email,
    password,
    confirmPassword,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'fullName': userName,
      'phone': mobileNumber,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AuthenticationResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/auth/register',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AuthenticationResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<VerifyEmailResponse> verifyEmail(
    code,
    token,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authentication': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'code': code};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<VerifyEmailResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/auth/verifyemail',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = VerifyEmailResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<HomeResponse> getHomeData(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<HomeResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/home/',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HomeResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ItemResponse> getProductData(productId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ItemResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/products/product/${productId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ItemResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ShowItemsResponse> getShowItemsData(
    purpose,
    category,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'purpose': purpose,
      r'category': category,
      r'page': page,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ShowItemsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/products/get',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ShowItemsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<SavingProductResponse> toggleSavingProduct(
    productId,
    token,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authentication': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'prodId': productId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<SavingProductResponse>(Options(
      method: 'PATCH',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/addToWishlist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = SavingProductResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ShowItemsResponse> getSavedProducts(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authentication': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ShowItemsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/users/getWishlist',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ShowItemsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<ShowItemsResponse> getShowProfileData(profileId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<ShowItemsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/Profile/${profileId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = ShowItemsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<AddAdvertisementResponse> addAdvertisement(
    image,
    name,
    price,
    description,
    sectionId,
    categoryId,
    conditionId,
    token,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'sectionId': sectionId,
      'categoryId': categoryId,
      'conditionId': conditionId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AddAdvertisementResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/customers/AddAdvertisement',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AddAdvertisementResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyProfileDataResponse> getMyProfileData(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authentication': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyProfileDataResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/get',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyProfileDataResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<GetMyProfileAdsResponse> getMyProfileAds(
    pageId,
    contentType,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'Authorization': contentType};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GetMyProfileAdsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/MyProfile/Ads/${pageId}',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GetMyProfileAdsResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<RemoveAdResponse> removeAd(
    itemId,
    token,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = {'itemId': itemId};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<RemoveAdResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/MyProfile/DeleteAd',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = RemoveAdResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<UpdateAdResponse> updateAd(
    itemId,
    token,
    image,
    name,
    price,
    description,
    sectionId,
    categoryId,
    conditionId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = {
      'itemId': itemId,
      'image': image,
      'name': name,
      'price': price,
      'description': description,
      'sectionId': sectionId,
      'categoryId': categoryId,
      'conditionId': conditionId,
    };
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<UpdateAdResponse>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/MyProfile/UpdateAd',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = UpdateAdResponse.fromJson(_result.data!);
    return value;
  }

  @override
  Future<NotificationsResponse> notifications(token) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{r'token': token};
    _headers.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<NotificationsResponse>(Options(
      method: 'GET',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/Notifications',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = NotificationsResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
