import 'package:dartz/dartz.dart';
import 'package:sed/domain/model/models.dart';
import '../../data/network/failure.dart';
import '../repository/repository.dart';
import 'base_usecase.dart';

class ResetPasswordOTPUseCase implements BaseUseCase<int, VerifyEMail> {
  final Repository _repository;

  ResetPasswordOTPUseCase(this._repository);

  @override
  Future<Either<Failure, VerifyEMail>> execute(int input) async {
    return await _repository.resetPasswordOTP(input);
  }
}
