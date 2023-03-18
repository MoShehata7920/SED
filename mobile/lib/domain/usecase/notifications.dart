import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:sed/domain/usecase/base_usecase.dart';

class NotificationsUseCase implements BaseUseCase<void, Notifications> {
  final Repository _repository;

  NotificationsUseCase(this._repository);

  @override
  Future<Either<Failure, Notifications>> execute(void x) async {
    return await _repository.notifications();
  }
}
