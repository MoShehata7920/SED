import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class RegisterUseCase
    implements BaseUseCase<RegisterUseCaseInput, Authentication> {
  final Repository _repository;

  RegisterUseCase(this._repository);

  @override
  Future<Either<Failure, Authentication>> execute(
      RegisterUseCaseInput input) async {
    return await _repository.register(RegisterRequest(
        input.userName,
        input.mobileNumber,
        input.email,
        input.password,
        input.confirmPassword));
  }
}

class RegisterUseCaseInput {
  String userName;
  String mobileNumber;
  String email;
  String password;
  String confirmPassword;

  RegisterUseCaseInput(this.userName, this.mobileNumber, this.email,
      this.password, this.confirmPassword);
}
