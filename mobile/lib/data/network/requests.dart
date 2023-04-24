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
  int pageId;
  String token;

  GetMyProfileAdsRequest(this.pageId, this.token);
}

class RemoveAdRequest {
  String itemId;

  RemoveAdRequest(this.itemId);
}

class UpdateAdRequest {
  String itemId;
  File image;
  String name;
  int price;
  String description;
  String purpose;
  String category;
  String condition;
  String token;

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

class SearchRequest {
  String searchText;

  SearchRequest(this.searchText);
}
