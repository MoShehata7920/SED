import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsManager.background,
          statusBarBrightness: Brightness.light),
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
          backgroundColor: ColorsManager.primaryColor,
          disabledBackgroundColor: ColorsManager.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s24),
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
            color: ColorsManager.secondaryText, fontSize: FontSize.s14),
        bodyLarge: getRegularStyle(color: ColorManager.grey1),
        bodySmall: getRegularStyle(color: ColorManager.grey)),

    //input decoration Theme (Text form field)
    inputDecorationTheme: InputDecorationTheme(
      //content padding
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      filled: true,
      fillColor: ColorsManager.textFormFieldBackGroundColorDark,
      //hint style
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),
      
      //enabled border style
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),

      //focused border style
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),

      //error border style
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),


      //focused border style
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Color(0x00000000),
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(20.0),
      ),
    ),
  );
}
