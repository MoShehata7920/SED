import 'package:dartz/dartz.dart';
import 'package:sed/domain/model/models.dart';

import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ForgotPasswordUseCase implements BaseUseCase<ForgotPasswordInput, ForgotPassword> {
  final Repository _repository;

  ForgotPasswordUseCase(this._repository);

  @override
  Future<Either<Failure, ForgotPassword>> execute(
      ForgotPasswordInput input) async {
    return await _repository.forgotPassword(input.email);
  }
}

class ForgotPasswordInput {
  String email;

  ForgotPasswordInput(this.email);
}