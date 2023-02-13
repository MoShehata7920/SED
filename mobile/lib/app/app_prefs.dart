import 'package:sed/presentation/resources/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String keyLang= "PREFS_KEY_LANG";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(keyLang);

    return language ?? LanguageType.ENGLISH.getValue();
  }
}