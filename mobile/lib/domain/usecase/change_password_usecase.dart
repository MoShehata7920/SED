import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class ChangePasswordUsecase
    implements BaseUseCase<ChangePasswordUsecaseInput, Default> {
  final Repository _repository;

  ChangePasswordUsecase(this._repository);

  @override
  Future<Either<Failure, Default>> execute(
      ChangePasswordUsecaseInput input) async {
    return await _repository.changePassword(ChangePasswordRequest(
      input.userId,
      input.oldPassword,
      input.newPassword,
      input.confirmNewPassword,
    ));
  }
}

class ChangePasswordUsecaseInput {
  String userId;
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePasswordUsecaseInput(
    this.userId,
    this.oldPassword,
    this.newPassword,
    this.confirmNewPassword,
  );
}
