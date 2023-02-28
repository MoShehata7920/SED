// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = json['status'] as int?
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
        Map<String, dynamic> json) =>
    AuthenticationResponse(
      json['token'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
        AuthenticationResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'token': instance.token,
    };

ForgotPasswordResponse _$ForgotPasswordResponseFromJson(
        Map<String, dynamic> json) =>
    ForgotPasswordResponse(
      json['support'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ForgotPasswordResponseToJson(
        ForgotPasswordResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'support': instance.support,
    };

HomeResponse _$HomeResponseFromJson(Map<String, dynamic> json) => HomeResponse(
      json['carousel'] == null
          ? null
          : CarouselResponse.fromJson(json['carousel'] as Map<String, dynamic>),
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : CategoriesResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['sellItems'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['donateItems'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['exchangeItems'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'carousel': instance.carousel,
      'categories': instance.categories,
      'sellItems': instance.sellItems,
      'donateItems': instance.donateItems,
      'exchangeItems': instance.exchangeItems,
    };

CarouselResponse _$CarouselResponseFromJson(Map<String, dynamic> json) =>
    CarouselResponse(
      (json['Images'] as List<dynamic>?)?.map((e) => e as String?).toList(),
    );

Map<String, dynamic> _$CarouselResponseToJson(CarouselResponse instance) =>
    <String, dynamic>{
      'Images': instance.images,
    };

CategoriesResponse _$CategoriesResponseFromJson(Map<String, dynamic> json) =>
    CategoriesResponse(
      json['ID'] as int?,
      json['Name'] as String?,
      json['Image'] as String?,
    );

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Name': instance.name,
      'Image': instance.image,
    };

ItemsResponse _$ItemsResponseFromJson(Map<String, dynamic> json) =>
    ItemsResponse(
      json['Name'] as String?,
      json['Image'] as String?,
      json['Descr'] as String?,
      json['Price'] as int?,
      json['CategoryId'] as int?,
    );

Map<String, dynamic> _$ItemsResponseToJson(ItemsResponse instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Image': instance.image,
      'Descr': instance.description,
      'Price': instance.price,
      'CategoryId': instance.categoryId,
    };
