// ignore: depend_on_referenced_packages
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sed/domain/model/models.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _loginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String userName,
    String mobileNumber,
    String email,
    String password,
    String confirmPassword
  ) = _registerObject;
}

@freezed
class AdvertisementObject with _$AdvertisementObject {
  factory AdvertisementObject(
      String image,
      String name,
      String price,
      String description,
      int sectionId,
      int categoryId,
      int conditionId) = _AdvertisementObject;
}

@freezed
class MyProfileAds with _$MyProfileAds {
  factory MyProfileAds(List<Items> items) = _MyProfileAds;
}
