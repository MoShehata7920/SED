// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

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

VerifyEmailResponse _$VerifyEmailResponseFromJson(Map<String, dynamic> json) =>
    VerifyEmailResponse()
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$VerifyEmailResponseToJson(
        VerifyEmailResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
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
      json['notificationsCount'] as int?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?
      ..sections = (json['sections'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : SectionResponse.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$HomeResponseToJson(HomeResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'carousel': instance.carousel,
      'categories': instance.categories,
      'sellItems': instance.sellItems,
      'donateItems': instance.donateItems,
      'exchangeItems': instance.exchangeItems,
      'sections': instance.sections,
      'notificationsCount': instance.notificationsCount,
    };

SectionResponse _$SectionResponseFromJson(Map<String, dynamic> json) =>
    SectionResponse(
      json['ID'] as int?,
      json['Image'] as String?,
      json['Name'] as String?,
    );

Map<String, dynamic> _$SectionResponseToJson(SectionResponse instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'Image': instance.image,
      'Name': instance.name,
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
      json['name'] as String?,
      json['Image'] as String?,
    );

Map<String, dynamic> _$CategoriesResponseToJson(CategoriesResponse instance) =>
    <String, dynamic>{
      'ID': instance.id,
      'name': instance.name,
      'Image': instance.image,
    };

ItemsResponse _$ItemsResponseFromJson(Map<String, dynamic> json) =>
    ItemsResponse(
      json['productName'] as String?,
      json['productImage'] as String?,
      json['description'] as String?,
      json['price'] as int?,
      json['category'] as String?,
      json['createdAt'] as String?,
      json['isSaved'] as bool?,
    )..id = json['_id'] as String?;

Map<String, dynamic> _$ItemsResponseToJson(ItemsResponse instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'productName': instance.name,
      'description': instance.description,
      'category': instance.category,
      'productImage': instance.image,
      'price': instance.price,
      'createdAt': instance.date,
      'isSaved': instance.isSaved,
    };

ItemResponse _$ItemResponseFromJson(Map<String, dynamic> json) => ItemResponse(
      json['product'] == null
          ? null
          : ItemsResponse.fromJson(json['product'] as Map<String, dynamic>),
      json['user'] == null
          ? null
          : UserDataResponse.fromJson(json['user'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ItemResponseToJson(ItemResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'product': instance.product,
      'user': instance.user,
    };

UserDataResponse _$UserDataResponseFromJson(Map<String, dynamic> json) =>
    UserDataResponse(
      json['id'] as int?,
      json['name'] as String?,
      json['phonenumber'] as String?,
      json['address'] as String?,
      json['image'] as String?,
    );

Map<String, dynamic> _$UserDataResponseToJson(UserDataResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phonenumber': instance.phone,
      'address': instance.address,
      'image': instance.image,
    };

ShowItemsResponse _$ShowItemsResponseFromJson(Map<String, dynamic> json) =>
    ShowItemsResponse(
      (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$ShowItemsResponseToJson(ShowItemsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'items': instance.showItems,
    };

SavingProductResponse _$SavingProductResponseFromJson(
        Map<String, dynamic> json) =>
    SavingProductResponse(
      json['savingProductStatus'] as bool?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SavingProductResponseToJson(
        SavingProductResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'savingProductStatus': instance.savingProductStatus,
    };

AddAdvertisementResponse _$AddAdvertisementResponseFromJson(
        Map<String, dynamic> json) =>
    AddAdvertisementResponse(
      json['image'] as String?,
      json['name'] as String?,
      json['price'] as int?,
      json['description'] as String?,
      json['purpose'] as String?,
      json['category'] as String?,
      json['condition'] as String?,
      json['token'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$AddAdvertisementResponseToJson(
        AddAdvertisementResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'purpose': instance.purpose,
      'category': instance.category,
      'condition': instance.condition,
      'token': instance.token,
    };

GetMyProfileDataResponse _$GetMyProfileDataResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyProfileDataResponse(
      json['user'] == null
          ? null
          : UserDataResponse.fromJson(json['user'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetMyProfileDataResponseToJson(
        GetMyProfileDataResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'user': instance.user,
    };

GetMyProfileAdsResponse _$GetMyProfileAdsResponseFromJson(
        Map<String, dynamic> json) =>
    GetMyProfileAdsResponse(
      (json['items'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : ItemsResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$GetMyProfileAdsResponseToJson(
        GetMyProfileAdsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'items': instance.items,
    };

RemoveAdResponse _$RemoveAdResponseFromJson(Map<String, dynamic> json) =>
    RemoveAdResponse(
      json['itemId'] as int?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$RemoveAdResponseToJson(RemoveAdResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'itemId': instance.itemId,
    };

UpdateAdResponse _$UpdateAdResponseFromJson(Map<String, dynamic> json) =>
    UpdateAdResponse(
      json['itemId'] as int?,
      json['image'] as String?,
      json['name'] as String?,
      json['price'] as int?,
      json['description'] as String?,
      json['purpose'] as String?,
      json['category'] as String?,
      json['condition'] as String?,
      json['token'] as String?,
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$UpdateAdResponseToJson(UpdateAdResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'itemId': instance.itemId,
      'image': instance.image,
      'name': instance.name,
      'price': instance.price,
      'description': instance.description,
      'purpose': instance.purpose,
      'category': instance.category,
      'condition': instance.condition,
      'token': instance.token,
    };

NotificationResponse _$NotificationResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationResponse(
      json['id'] as int?,
      json['title'] as String?,
      json['description'] as String?,
      json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      json['isSeen'] as bool?,
    );

Map<String, dynamic> _$NotificationResponseToJson(
        NotificationResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'dateTime': instance.dateTime?.toIso8601String(),
      'isSeen': instance.isSeen,
    };

NotificationsResponse _$NotificationsResponseFromJson(
        Map<String, dynamic> json) =>
    NotificationsResponse(
      (json['notifications'] as List<dynamic>?)
          ?.map((e) => NotificationResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$NotificationsResponseToJson(
        NotificationsResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'notifications': instance.notifications,
    };

SearchResponse _$SearchResponseFromJson(Map<String, dynamic> json) =>
    SearchResponse(
      ShowItemsResponse.fromJson(
          json['searchedProducts'] as Map<String, dynamic>),
    )
      ..status = json['status'] as int?
      ..message = json['message'] as String?;

Map<String, dynamic> _$SearchResponseToJson(SearchResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'searchedProducts': instance.searchedProducts,
    };
