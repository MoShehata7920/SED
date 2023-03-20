// ignore: depend_on_referenced_packages
import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable() //json_serializable dependency
class BaseResponse {
  @JsonKey(name: "status") //this depend on the name in the API
  int? status; //this is the usable on the project
  @JsonKey(name: "message") //this depend on the name in the API
  String? message;
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  @JsonKey(name: "token")
  String? token;

  AuthenticationResponse(this.token);

  // From Json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ForgotPasswordResponse extends BaseResponse {
  @JsonKey(name: "support")
  String? support;

  ForgotPasswordResponse(this.support);

  // From Json
  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}

@JsonSerializable()
class HomeResponse extends BaseResponse {
  @JsonKey(name: "carousel")
  CarouselResponse? carousel;

  @JsonKey(name: "categories")
  List<CategoriesResponse?>? categories;

  @JsonKey(name: "sellItems")
  List<ItemsResponse?>? sellItems;

  @JsonKey(name: "donateItems")
  List<ItemsResponse?>? donateItems;

  @JsonKey(name: "exchangeItems")
  List<ItemsResponse?>? exchangeItems;

  @JsonKey(name: "sections")
  List<SectionResponse?>? sections;

  @JsonKey(name: "notificationsCount")
  int? notificationsCount;
  HomeResponse(this.carousel, this.categories, this.sellItems, this.donateItems,
      this.exchangeItems, this.notificationsCount);

  // From Json
  factory HomeResponse.fromJson(Map<String, dynamic> json) =>
      _$HomeResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$HomeResponseToJson(this);
}

@JsonSerializable()
class SectionResponse {
  @JsonKey(name: "ID")
  int? id;

  @JsonKey(name: "Image")
  String? image;

  @JsonKey(name: "Name")
  String? name;

  SectionResponse(this.id, this.image, this.name);

  // From Json
  factory SectionResponse.fromJson(Map<String, dynamic> json) =>
      _$SectionResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$SectionResponseToJson(this);
}

@JsonSerializable()
class CarouselResponse {
  @JsonKey(name: "Images")
  List<String?>? images;

  CarouselResponse(this.images);

  // from json
  factory CarouselResponse.fromJson(Map<String, dynamic> json) =>
      _$CarouselResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$CarouselResponseToJson(this);
}

@JsonSerializable()
class CategoriesResponse {
  @JsonKey(name: "ID")
  int? id;

  @JsonKey(name: "Name")
  String? name;

  @JsonKey(name: "Image")
  String? image;

  CategoriesResponse(this.id, this.name, this.image);

  // from json
  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$CategoriesResponseToJson(this);
}

@JsonSerializable()
class ItemsResponse {
  @JsonKey(name: "ID")
  int? id;

  @JsonKey(name: "Name")
  String? name;

  @JsonKey(name: "Image")
  String? image;

  @JsonKey(name: "Descr")
  String? description;

  @JsonKey(name: "Price")
  int? price;

  @JsonKey(name: "CategoryId")
  int? categoryId;

  @JsonKey(name: "Date")
  String? date;

  @JsonKey(name: "isSaved")
  bool? isSaved;

  ItemsResponse(this.name, this.image, this.description, this.price,
      this.categoryId, this.date, this.isSaved);

  // From Json
  factory ItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ItemsResponseToJson(this);
}

@JsonSerializable()
class ItemResponse extends BaseResponse {
  @JsonKey(name: "item")
  ItemsResponse? item;

  @JsonKey(name: "user")
  UserDataResponse? user;

  ItemResponse(this.item, this.user);

  // From Json
  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "phonenumber")
  String? phone;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "image")
  String? image;

  UserDataResponse(this.id, this.name, this.phone, this.address, this.image);

  // From Json
  factory UserDataResponse.fromJson(Map<String, dynamic> json) =>
      _$UserDataResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$UserDataResponseToJson(this);
}

@JsonSerializable()
class ShowItemsResponse extends BaseResponse {
  @JsonKey(name: "items")
  List<ItemsResponse?>? showItems;

  ShowItemsResponse(this.showItems);

  // From Json
  factory ShowItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ShowItemsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ShowItemsResponseToJson(this);
}

@JsonSerializable()
class SavingProductResponse extends BaseResponse {
  @JsonKey(name: "savingProductStatus")
  bool? savingProductStatus;

  SavingProductResponse(this.savingProductStatus);

  // From Json
  factory SavingProductResponse.fromJson(Map<String, dynamic> json) =>
      _$SavingProductResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$SavingProductResponseToJson(this);
}

@JsonSerializable()
class AddAdvertisementResponse extends BaseResponse {
  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "sectionId")
  int? sectionId;

  @JsonKey(name: "categoryId")
  int? categoryId;

  @JsonKey(name: "conditionId")
  int? conditionId;

  @JsonKey(name: "token")
  String? token;

  AddAdvertisementResponse(this.image, this.name, this.price, this.description,
      this.sectionId, this.categoryId, this.conditionId, this.token);

  // From Json
  factory AddAdvertisementResponse.fromJson(Map<String, dynamic> json) =>
      _$AddAdvertisementResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$AddAdvertisementResponseToJson(this);
}

@JsonSerializable()
class GetMyProfileDataResponse extends BaseResponse {
  @JsonKey(name: "user")
  UserDataResponse? user;

  GetMyProfileDataResponse(this.user);

  // From Json
  factory GetMyProfileDataResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMyProfileDataResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$GetMyProfileDataResponseToJson(this);
}

@JsonSerializable()
class GetMyProfileAdsResponse extends BaseResponse {
  @JsonKey(name: "items")
  List<ItemsResponse?>? items;

  GetMyProfileAdsResponse(this.items);

  // From Json
  factory GetMyProfileAdsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetMyProfileAdsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$GetMyProfileAdsResponseToJson(this);
}

@JsonSerializable()
class RemoveAdResponse extends BaseResponse {
  @JsonKey(name: "itemId")
  int? itemId;

  RemoveAdResponse(this.itemId);

  // From Json
  factory RemoveAdResponse.fromJson(Map<String, dynamic> json) =>
      _$RemoveAdResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$RemoveAdResponseToJson(this);
}

@JsonSerializable()
class UpdateAdResponse extends BaseResponse {
  @JsonKey(name: "itemId")
  int? itemId;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "price")
  String? price;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "sectionId")
  int? sectionId;

  @JsonKey(name: "categoryId")
  int? categoryId;

  @JsonKey(name: "conditionId")
  int? conditionId;

  @JsonKey(name: "token")
  String? token;

  UpdateAdResponse(
      this.itemId,
      this.image,
      this.name,
      this.price,
      this.description,
      this.sectionId,
      this.categoryId,
      this.conditionId,
      this.token);

  // From Json
  factory UpdateAdResponse.fromJson(Map<String, dynamic> json) =>
      _$UpdateAdResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$UpdateAdResponseToJson(this);
}

@JsonSerializable()
class NotificationResponse {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "title")
  String? title;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "dateTime")
  DateTime? dateTime;

  @JsonKey(name: "isSeen")
  bool? isSeen;

  NotificationResponse(
      this.id, this.title, this.description, this.dateTime, this.isSeen);

  // From Json
  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}

@JsonSerializable()
class NotificationsResponse extends BaseResponse {
  @JsonKey(name: "notifications")
  List<NotificationResponse>? notifications;

  NotificationsResponse(this.notifications);

  // From Json
  factory NotificationsResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$NotificationsResponseToJson(this);
}
