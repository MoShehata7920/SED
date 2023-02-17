import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/data/network/app_api.dart';
import 'package:sed/data/network/dio_factory.dart';
import 'package:sed/data/network/network_info.dart';
import 'package:sed/data/repository/repository_impl.dart';
import 'package:sed/data/source/remote_data_source.dart';
import 'package:sed/domain/repository/repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  //app module, its a module where we put all generic dependencies

  //shared prefs instance
  final sharedPrefs = await SharedPreferences.getInstance();

  instance.registerLazySingleton<SharedPreferences>(() =>
      sharedPrefs); //app preference needs an instance of shared preference so we have to initialize one first.

  // app prefs instance
  instance.registerLazySingleton<AppPreferences>(() =>
      AppPreferences(instance())); //instance() gets the required instance so it returns sharedPrefs at this case.

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  // dio factory
  instance.registerLazySingleton<DioFactory>(() =>
      DioFactory(instance()));

  Dio dio = await instance<DioFactory>().getDio();

  //app service client
  instance.registerLazySingleton<AppServiceClient>(() =>
      AppServiceClient(dio));

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(instance<AppServiceClient>()));

  // repository
  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance()));
}

Future<void> initLoginModule() async {}
