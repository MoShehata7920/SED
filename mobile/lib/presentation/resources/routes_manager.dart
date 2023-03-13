import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/login/view/login_view.dart';
import 'package:sed/presentation/main_screen/items_screen/showProfile/view/show_profile_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/add_product_screen/view/add_advertisement_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/add_product_screen/categories/categories_screen_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/settings_sub_screens/my_ads_screen/my_ads_view.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view/show_items_screen_view.dart';
import 'package:sed/presentation/onboarding/view/onboarding_view.dart';
import 'package:sed/presentation/register/view/register_view.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../forgot_password/view/forgotpassword_view.dart';
import '../main_screen/items_screen/view/items_screen_view.dart';
import '../main_screen/main_screen_view/main_screen_view.dart';
import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String registerRoute = "/register";
  static const String mainScreenRoute = "/main";
  static const String itemScreenRoute = "/item";
  static const String showItemsScreenRoute = "/showItems";
  static const String categoriesScreenRoute = "/categories";
  static const String showProfileScreenRoute = "/showProfile";
  static const String addProductScreenRoute = "/addProduct";
  static const String myAdsScreenRoute = "/myAds";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());

      case Routes.loginRoute:
        initLoginModule();
        return MaterialPageRoute(builder: (context) => const LoginView());

      case Routes.forgotPasswordRoute:
        initForgotPasswordModule();
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordView());

      case Routes.registerRoute:
        initRegisterModule();
        return MaterialPageRoute(builder: (context) => const RegisterView());

      case Routes.mainScreenRoute:
        return MaterialPageRoute(builder: (context) => const MainScreenView());

      case Routes.itemScreenRoute:
        return MaterialPageRoute(
            builder: (context) => ItemView(settings.arguments));

      case Routes.showItemsScreenRoute:
        List<dynamic> args = settings.arguments as List<dynamic>;
        return MaterialPageRoute(
            builder: (context) => ShowItemsView(
                  args[0],
                  categoryId: args[1],
                ));

      case Routes.categoriesScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const CategoriesScreenView());

      // show profile screen for other users
      case Routes.showProfileScreenRoute:
        return MaterialPageRoute(
            builder: (context) => ShowProfileView(settings.arguments));

      case Routes.addProductScreenRoute:
        return MaterialPageRoute(
            builder: (context) =>
                AddAdvertisementView(settings.arguments as int));

      case Routes.myAdsScreenRoute:
        return MaterialPageRoute(builder: (context) => const MyAdsScreenView());

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text(AppStrings.noRouteTitle),
              ),
              body: const Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}
