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
  int type;
  int offset;

  ShowItemsRequest(this.type, this.offset);
}
