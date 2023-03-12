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
  String countryMobileCode;
  String mobileNumber;
  String email;
  String password;

  RegisterRequest(this.userName, this.countryMobileCode, this.mobileNumber,
      this.email, this.password);
}

class ShowItemsRequest {
  String type;
  int offset;

  ShowItemsRequest(this.type, this.offset);
}

class SavingProductRequest {
  int productId;

  SavingProductRequest(this.productId);
}

class AddAdvertisementRequest {
  String image;
  String name;
  String price;
  String description;
  int sectionId;
  int categoryId;
  int conditionId;

  AddAdvertisementRequest(this.image, this.name, this.price, this.description,
      this.sectionId, this.categoryId, this.conditionId);
}
