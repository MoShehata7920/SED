import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class ResetPasswordUsecase
    implements BaseUseCase<ResetPasswordUsecaseInput, Default> {
  final Repository _repository;

  ResetPasswordUsecase(this._repository);

  @override
  Future<Either<Failure, Default>> execute(
      ResetPasswordUsecaseInput input) async {
    return await _repository.resetPassword(ResetPasswordRequest(

      input.newPassword,
      input.confirmNewPassword,
    ));
  }
}

class ResetPasswordUsecaseInput {
  String newPassword;
  String confirmNewPassword;

  ResetPasswordUsecaseInput(
    this.newPassword,
    this.confirmNewPassword,
  );
}
