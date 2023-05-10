import 'dart:io';

class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest(this.email);
}

class RegisterRequest {
  String userName;
  String mobileNumber;
  String email;
  String password;
  String confirmPassword;

  RegisterRequest(this.userName, this.mobileNumber, this.email, this.password,
      this.confirmPassword);
}

class VerifyEmailRequest {
  int code;

  VerifyEmailRequest(
    this.code,
  );
}

class ShowItemsRequest {
  String purpose;
  String category;
  int page;
  ShowItemsRequest(
      {this.purpose = "all", this.category = "all", this.page = 1});
}

class SavingProductRequest {
  String productId;

  SavingProductRequest(this.productId);
}

class AddAdvertisementRequest {
  File image;
  String name;
  int price;
  String description;
  String purpose;
  String category;
  String condition;
  String token;

  AddAdvertisementRequest(this.image, this.name, this.price, this.description,
      this.purpose, this.category, this.condition, this.token);
}

class GetMyProfileAdsRequest {
  String sellerId;
  String token;

  GetMyProfileAdsRequest(this.sellerId, this.token);
}

class RemoveAdRequest {
  String itemId;

  RemoveAdRequest(this.itemId);
}

class UpdateAdRequest {
  String? itemId;
  File? image;
  String? name;
  int? price;
  String? description;
  String? purpose;
  String? category;
  String? condition;
  String? token;

  UpdateAdRequest(
      this.itemId,
      this.image,
      this.name,
      this.price,
      this.description,
      this.purpose,
      this.category,
      this.condition,
      this.token);
}

class UpdateUserProfileRequest {
  String? userId;
  File? userImage;
  String? name;
  String? phoneNumber;
  String? government;
  String? address;

  UpdateUserProfileRequest(
    this.userId,
    this.userImage,
    this.name,
    this.phoneNumber,
    this.government,
    this.address,
  );
}

class ChangePasswordRequest {
  String userId;
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePasswordRequest(
    this.userId,
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,

  );
}

class SearchRequest {
  String searchText;

  SearchRequest(this.searchText);
}

// Chat
class NewConversationRequest {
  String senderId;
  String receiverId;

  NewConversationRequest(this.senderId,this.receiverId);
}

class GetAllConversationsRequest {
  String userId;

  GetAllConversationsRequest(this.userId);
}

class ChatMessagesRequest {
  String conversationId;

  ChatMessagesRequest(this.conversationId);
}

class NewMessageRequest {
  String conversationId;
  String senderId;
  String text;

  NewMessageRequest(this.conversationId, this.senderId, this.text);
}