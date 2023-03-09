import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/fonts_manager.dart';
import 'package:sed/presentation/resources/styles_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

import 'color_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    //main colors
    primaryColorLight: ColorManager.lightPrimary,
    primaryColorDark: ColorManager.darkPrimary,
    disabledColor: ColorManager.grey1,
    splashColor: ColorManager.lightPrimary,
    // todo , use colorScheme instead of backgroundColor
    backgroundColor: ColorManager.backGroundLightPrimary,

    //cardView  Theme
    cardTheme: CardTheme(
        color: ColorManager.white,
        shadowColor: ColorManager.grey,
        elevation: AppSize.s4),

    //app bar theme
    appBarTheme: AppBarTheme(
      centerTitle: true,
      color: ColorManager.lightPrimary,
      elevation: AppSize.s4,
      shadowColor: ColorManager.lightPrimary,
      titleTextStyle:
          getRegularStyle(fontSize: FontSize.s16, color: ColorManager.white),
    ),

    //button Theme
    buttonTheme: ButtonThemeData(
      shape: const StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.lightPrimary,
      splashColor: ColorManager.lightPrimary,
    ),

    //elevated button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: getRegularStyle(
              fontSize: FontSize.s17, color: ColorManager.white),
          backgroundColor: ColorManager.secondLightPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s12),
          )),
    ),

    //text theme
    textTheme: TextTheme(
        displayLarge:
            getLightStyle(color: ColorManager.darkGrey, fontSize: FontSize.s22),
        headlineLarge: getSemiBoldStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s16),
        headlineMedium: getRegularStyle(
            color: ColorManager.darkGrey, fontSize: FontSize.s14),
        titleMedium: getMediumStyle(
            color: ColorManager.lightPrimary, fontSize: FontSize.s16),
        bodyLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey)),

    //input decoration Theme (Text form field)
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),

      //hint style
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),

      //enabled border style
      // enabledBorder: OutlineInputBorder(
      //     borderSide:
      //         BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
      //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
      ),

      //focused border style
      // focusedBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //         color: ColorManager.lightPrimary, width: AppSize.s1_5),
      //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
      ),

      //error border style
      // errorBorder: OutlineInputBorder(
      //     borderSide:
      //         BorderSide(color: ColorManager.error, width: AppSize.s1_5),
      //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8))),

      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
      ),

      //focused border style
      // focusedErrorBorder: OutlineInputBorder(
      //     borderSide: BorderSide(
      //         color: ColorManager.lightPrimary, width: AppSize.s1_5),
      //     borderRadius: const BorderRadius.all(Radius.circular(AppSize.s8)))

      focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4.0),
          topRight: Radius.circular(4.0),
        ),
      ),
    ),
  );
}
