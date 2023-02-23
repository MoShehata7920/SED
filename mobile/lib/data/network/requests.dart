class LoginRequest {
  String email;
  String password;

  LoginRequest(this.email, this.password);
}

class ForgotPasswordRequest {
  String email;

  ForgotPasswordRequest(this.email);
}