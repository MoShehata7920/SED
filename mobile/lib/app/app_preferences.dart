// ignore_for_file: constant_identifier_names

import 'package:sed/app/constants.dart';
import 'package:sed/presentation/resources/constants_manager.dart';
import 'package:sed/presentation/resources/language_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

const String keyLang = "PREFS_KEY_LANG";
const String PREFS_KEY_ONBOARDING_SCREEN_VIEWED =
    "PREFS_KEY_ONBOARDING_SCREEN_VIEWED";
const String PREFS_KEY_IS_USER_LOGGED_IN = "PREFS_KEY_IS_USER_LOGGED_IN";
const String PREFS_KEY_TOKEN = "TOKEN";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(keyLang);

    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      return LanguageType.ENGLISH.getValue(); // return default lang
    }
  }

  // OnBoarding
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(PREFS_KEY_ONBOARDING_SCREEN_VIEWED) ??
        false;
  }

  // Login
  Future<void> setUserLoggedInSuccessfully() async {
    _sharedPreferences.setBool(PREFS_KEY_IS_USER_LOGGED_IN, true);
  }

  Future<bool> isUserLoggedInSuccessfully() async {
    return _sharedPreferences.getBool(PREFS_KEY_IS_USER_LOGGED_IN) ?? false;
  }

  Future<void> setToken(String token) async {
    _sharedPreferences.setString(PREFS_KEY_TOKEN, token);

    Constants.token = token;
  }

  Future<String> getToken() async {
    String? token = _sharedPreferences.getString(PREFS_KEY_TOKEN);

    return token ?? AppStrings.empty;
  }
}
