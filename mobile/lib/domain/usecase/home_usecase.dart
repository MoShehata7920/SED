import 'package:dartz/dartz.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';

import 'base_usecase.dart';

class HomeUseCase implements BaseUseCase<void, Home> {
  final Repository _repository;

  HomeUseCase(this._repository);

  @override
  Future<Either<Failure, Home>> execute(void home) async {
    return await _repository.getHomeData();
  }
}
