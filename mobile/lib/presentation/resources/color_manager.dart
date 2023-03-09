import 'package:flutter/cupertino.dart';

class ColorManager {
  static Color backGroundLightPrimary = const Color(0xffEEE9DA);
  static Color backGroundDarkPrimary = const Color(0xff1D2951);

  static Color lightPrimary = const Color(0xff18122B);
  static Color secondLightPrimary = const Color(0xff393053);
  static Color thirdLightPrimary = const Color(0xff443C68);
  static Color fourthLightPrimary = const Color(0xff635985);
  static Color fifthLightPrimary = const Color(0xffE5D1FA);

  static Gradient firstLightPrimaryMix = LinearGradient(colors: <Color>[
    ColorManager.lightPrimary,
    ColorManager.thirdLightPrimary
  ]);
  static Gradient secondLightPrimaryMix = LinearGradient(colors: <Color>[
    ColorManager.secondLightPrimary,
    ColorManager.thirdLightPrimary
  ]);
  static Gradient thirdLightPrimaryMix = LinearGradient(colors: <Color>[
    ColorManager.fifthLightPrimary,
    ColorManager.thirdLightPrimary
  ]);

  static Color darkPrimary = const Color(0xffEAAA31);

  static Color darkGrey = const Color(0xff525252);
  static Color grey = const Color(0xff737477);
  static Color lightGrey = const Color(0xffD9D9D6);
  static Color black = const Color(0xff000000);

  static Color grey1 = const Color(0xff707070);
  static Color grey2 = const Color(0xff797979);
  static Color white = const Color(0xffFFFFFF);
  static Color error = const Color(0xffe61f34);
}

class ColorsManager {
  static Color primaryBackGroundColorDark = const Color(0xFF1A1F24);
  static Color textFormFieldBackGroundColorDark = const Color(0xff1A1F24);
  static Color dark900 = const Color(0xFF1A1F24);
  static Color grayDark = const Color(0xFF95A1AC);

  static Color primaryColor = const Color(0xFF4B39EF);
  static Color secondaryColor = const Color(0xFFEE8B60);
  static Color tertiaryColor = const Color(0xFFFFFFFF);
  static Color alternate = const Color(0xFF39D2C0);
  static Color primaryBackground = const Color(0xFF1A1F24);
  static Color secondaryBackground = const Color(0xFF090F13);
  static Color primaryText = const Color(0xFFFFFFFF);
  static Color secondaryText = const Color(0xFF95A1AC);
  static Color background = const Color(0xFF14181B);
  static Color grayIcon = const Color(0xFF95A1AC);
  static Color tertiary = const Color(0xFF39D2C0);
}
