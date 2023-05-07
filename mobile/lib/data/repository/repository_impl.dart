import 'package:dartz/dartz.dart';
import 'package:sed/data/mapper/mapper.dart';
import 'package:sed/data/network/error_handler.dart';
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
  Future<Either<Failure, Authentication>> login(
      LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.login(loginRequest);
        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          //return data
          //return either right
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword(String email) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.forgotPassword(email);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success
          return Right(response.toDomain());
        } else {
          //failure
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Authentication>> register(
      RegisterRequest registerRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.register(registerRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Home>> getHomeData() async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.getHomeData();

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left

          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Item>> getProductData(String productId) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.getProductData(productId);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ShowItems>> getShowItems(
      ShowItemsRequest showItemsRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.getShowItemsData(showItemsRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, SavingProduct>> toggleSavingProduct(
      SavingProductRequest savingProductRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.toggleSavingProduct(savingProductRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ShowItems>> getShowProfile(
      ShowProfileRequest showProfileRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.getShowProfile(showProfileRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, AddAdvertisement>> addAdvertisement(
      AddAdvertisementRequest addAdvertisementRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.addAdvertisement(addAdvertisementRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, GetMyProfileData>> getMyProfileData(
      String token) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.getMyProfileData(token);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, GetMyProfileAds>> getMyProfileAds(
      GetMyProfileAdsRequest getMyProfileAdsRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.getMyProfileAds(getMyProfileAdsRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, RemoveAd>> removeAd(
      RemoveAdRequest removeAdRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.removeAd(removeAdRequest.itemId);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UpdateAd>> updateAd(
      UpdateAdRequest updateAdRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.updateAd(updateAdRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Notifications>> notifications() async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.notifications();

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, VerifyEMail>> verifyEmail(int code) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.verifyEmail(code);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ShowItems>> getSavedProducts() async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response = await _remoteDataSource.getSavedProducts();

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, ShowItems>> getSearchedProducts(
      String searchText) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.getSearchedProducts(searchText);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Default>> updateUserProfile(
      UpdateUserProfileRequest updateUserProfileRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.updateUserProfile(updateUserProfileRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Default>> changePassword(
      ChangePasswordRequest changePasswordRequest) async {
    if (await _networkInfo.isConnected) {
      //device is connected to the internet, call api
      try {
        final response =
            await _remoteDataSource.changePassword(changePasswordRequest);

        if (response.status == ApiInternalStatus.SUCCESS) {
          //success , return data
          return Right(response.toDomain());
        } else {
          //failure
          //return either left
          return Left(Failure(ApiInternalStatus.FAILURE,
              response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error) {
        print(error);
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      //return connection error
      //return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
