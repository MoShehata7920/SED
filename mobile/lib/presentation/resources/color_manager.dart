import 'package:flutter/cupertino.dart';
import 'package:sed/presentation/resources/theme_manager.dart';

class ColorsManager {
  static Color darkBlack = const Color(0xFF080e13);
  static Color textFormFieldBackGroundColorDark = const Color(0xff1A1F24);
  static Color dark900 = const Color(0xFF1A1F24);
  static Color grayDark = const Color(0xFF95A1AC);

  static Color get primaryColor => ThemeManager.isDarkMode
      ? const Color(0xFF96C3E2)
      : const Color(0xFF008CBA);
  static Color get secondaryColor => ThemeManager.isDarkMode
      ? const Color(0xFFEE8B60)
      : const Color(0xFFFFA07A);
  static Color get tertiaryColor => ThemeManager.isDarkMode
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF363636);
  static Color get alternate => ThemeManager.isDarkMode
      ? const Color(0xFF39D2C0)
      : const Color(0xFF03DAC5);
  static Color get primaryBackground => ThemeManager.isDarkMode
      ? const Color(0xFF192324)
      : const Color(0xFFF5F5F5);
  static Color get secondaryBackground => ThemeManager.isDarkMode
      ? const Color(0xFF283636)
      : const Color(0xFFEEEEEE);
  static Color get primaryText => ThemeManager.isDarkMode
      ? const Color(0xFFFFFFFF)
      : const Color(0xFF333333);
  static Color get secondaryText => ThemeManager.isDarkMode
      ? const Color(0xFF95A1AC)
      : const Color(0xFF666666);
  static Color get background => ThemeManager.isDarkMode
      ? const Color(0xFF14181B)
      : const Color(0xFFFFFFFF);
  static Color get grayIcon => ThemeManager.isDarkMode
      ? const Color(0xFF95A1AC)
      : const Color(0xFFBDBDBD);
  static Color get tertiary => ThemeManager.isDarkMode
      ? const Color(0xFF39D2C0)
      : const Color(0xFF03DAC5);
  static Color get primaryBtnText => ThemeManager.isDarkMode
      ? const Color(0xFF6E6E6E)
      : const Color(0xFFFAFAFA);

  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color lightGrey = const Color(0xffD9D9D6);
  static Color black = const Color(0xff000000);

  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static Color get white => ThemeManager.isDarkMode
      ? const Color(0xffFFFFFF)
      : const Color(0xFF000000);
  static Color error = const Color(0xffe61f34);

  static Color lineColor = const Color(0xFF9E9E9E);
}
