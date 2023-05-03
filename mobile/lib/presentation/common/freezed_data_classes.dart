// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sed/domain/model/models.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
class LoginObject with _$LoginObject {
  factory LoginObject(String userName, String password) = _loginObject;
}

@freezed
class RegisterObject with _$RegisterObject {
  factory RegisterObject(String userName, String mobileNumber, String email,
      String password, String confirmPassword) = _registerObject;
}

@freezed
class UserProfileObject with _$UserProfileObject {
  factory UserProfileObject(
    File userImage,
    String userName,
    String userPhone,
    String government,
    String address,
  ) = _userProfileObject;
}

@freezed
class AdvertisementObject with _$AdvertisementObject {
  factory AdvertisementObject(
      File image,
      String name,
      int price,
      String description,
      String purpose,
      String category,
      String condition) = _AdvertisementObject;
}

@freezed
class MyProfileAds with _$MyProfileAds {
  factory MyProfileAds(List<Items> items) = _MyProfileAds;
}
