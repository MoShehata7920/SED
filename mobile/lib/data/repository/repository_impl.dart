import 'package:dartz/dartz.dart';
import 'package:sed/data/mapper/mapper.dart';
import 'package:sed/data/network/failure.dart';
import 'package:sed/data/network/network_info.dart';
import 'package:sed/data/network/requests.dart';
import 'package:sed/data/source/remote_data_source.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/domain/repository/repository.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest) async {
    if(await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      final response = await _remoteDataSource.login(loginRequest);

      if(response.status == 0) {
        //success
        //return data
        //return either right
        return Right(response.toDomain());
      }else {
        //failure
        //return either left
        return Left(Failure(409,response.message ?? "business error message"));
      }
    }
    else {
      //return connection error
      //return either left
      return Left(Failure(501,"please check your internet connection"));
    }
  }
}