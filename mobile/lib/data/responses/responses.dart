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
class VerifyEmailResponse extends BaseResponse {
  VerifyEmailResponse();
  // From Json
  factory VerifyEmailResponse.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$VerifyEmailResponseToJson(this);
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
class ResetPasswordOTPResponse extends BaseResponse {
  String? token;
  ResetPasswordOTPResponse(this.token);
  // From Json
  factory ResetPasswordOTPResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordOTPResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ResetPasswordOTPResponseToJson(this);
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

  @JsonKey(name: "name")
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
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "productName")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "condition")
  String? condition;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "productImage")
  String? image;

  @JsonKey(name: "price")
  int? price;

  @JsonKey(name: "createdAt")
  String? date;

  @JsonKey(name: "isSaved")
  bool? isSaved;

  ItemsResponse(this.name, this.image, this.description, this.price,
      this.category, this.date, this.isSaved);

  // From Json
  factory ItemsResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ItemsResponseToJson(this);
}

@JsonSerializable()
class ItemResponse extends BaseResponse {
  @JsonKey(name: "product")
  ItemsResponse? product;

  @JsonKey(name: "sellerInfo")
  UserDataResponse? user;

  ItemResponse(this.product, this.user);

  // From Json
  factory ItemResponse.fromJson(Map<String, dynamic> json) =>
      _$ItemResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ItemResponseToJson(this);
}

@JsonSerializable()
class UserDataResponse {
  @JsonKey(name: "_id")
  String? id;

  @JsonKey(name: "fullName")
  String? name;

  @JsonKey(name: "userImage")
  String? image;

  @JsonKey(name: "phone")
  String? phone;

  @JsonKey(name: "government")
  String? government;

  @JsonKey(name: "address")
  String? address;

  @JsonKey(name: "isVerified")
  bool? isVerified;

  UserDataResponse(this.id, this.name, this.image, this.phone, this.government,
      this.address, this.isVerified);

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
  int? price;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "purpose")
  String? purpose;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "condition")
  String? condition;

  @JsonKey(name: "token")
  String? token;

  AddAdvertisementResponse(this.image, this.name, this.price, this.description,
      this.purpose, this.category, this.condition, this.token);

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
  @JsonKey(name: "products")
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
  int? price;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "purpose")
  String? purpose;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "condition")
  String? condition;

  @JsonKey(name: "token")
  String? token;

  UpdateAdResponse(
      this.itemId,
      this.image,
      this.name,
      this.price,
      this.description,
      this.purpose,
      this.category,
      this.condition,
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

@JsonSerializable()
class SearchResponse extends BaseResponse {
  @JsonKey(name: "searchedProducts")
  ShowItemsResponse searchedProducts;

  SearchResponse(this.searchedProducts);

  // From Json
  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}

@JsonSerializable()
class DefaultResponse extends BaseResponse {
  DefaultResponse();

  // From Json
  factory DefaultResponse.fromJson(Map<String, dynamic> json) =>
      _$DefaultResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$DefaultResponseToJson(this);
}

// Chat
@JsonSerializable()
class NewConversationResponse extends BaseResponse {
  @JsonKey(name: "savedConversation")
  SavedConversationsResponse? savedConversation;

  NewConversationResponse(this.savedConversation);

  // From Json
  factory NewConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$NewConversationResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$NewConversationResponseToJson(this);
}

@JsonSerializable()
class SavedConversationsResponse extends BaseResponse {
  @JsonKey(name: "_id")
  String? conversationId;

  SavedConversationsResponse(this.conversationId);

  // From Json
  factory SavedConversationsResponse.fromJson(Map<String, dynamic> json) =>
      _$SavedConversationsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$SavedConversationsResponseToJson(this);
}

@JsonSerializable()
class GetAllConversationsResponse extends BaseResponse {
  @JsonKey(name: "conversations")
  List<ConversationsResponse?>? conversations;

  GetAllConversationsResponse(this.conversations);

  // From Json
  factory GetAllConversationsResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAllConversationsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$GetAllConversationsResponseToJson(this);
}

@JsonSerializable()
class ConversationsResponse extends BaseResponse {
  @JsonKey(name: "_id")
  String? conversationId;

  @JsonKey(name: "users")
  List<UserDataResponse?>? usersData;

  @JsonKey(name: "lastMessage")
  String? lastMessage;

  @JsonKey(name: "createdAt")
  DateTime? createdAt;

  ConversationsResponse(this.conversationId, this.usersData, this.lastMessage, this.createdAt);

  // From Json
  factory ConversationsResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationsResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$ConversationsResponseToJson(this);
}

@JsonSerializable()
class GetChatMessagesResponse extends BaseResponse {
  @JsonKey(name: "messages")
  List<MessagesResponse?>? messages;

  GetChatMessagesResponse(this.messages);

  // From Json
  factory GetChatMessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetChatMessagesResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$GetChatMessagesResponseToJson(this);
}

@JsonSerializable()
class NewMessageResponse extends BaseResponse {
  @JsonKey(name: "savedMessage")
  MessagesResponse? savedMessage;

  NewMessageResponse(this.savedMessage);

  // From Json
  factory NewMessageResponse.fromJson(Map<String, dynamic> json) =>
      _$NewMessageResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$NewMessageResponseToJson(this);
}

@JsonSerializable()
class MessagesResponse extends BaseResponse {
  @JsonKey(name: "conversation")
  String? conversationId;

  @JsonKey(name: "sender")
  String? senderId;

  @JsonKey(name: "text")
  String? text;

  @JsonKey(name: "createdAt")
  String? createdAt;

  MessagesResponse(
      this.conversationId, this.senderId, this.text, this.createdAt);

  // From Json
  factory MessagesResponse.fromJson(Map<String, dynamic> json) =>
      _$MessagesResponseFromJson(json);

  // To Json
  Map<String, dynamic> toJson() => _$MessagesResponseToJson(this);
}
