import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/login/view/login_view.dart';
import 'package:sed/presentation/main_screen/items_screen/viewmodel/items_screen_viewmodel.dart';
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
        return MaterialPageRoute(
            builder: (context) => ShowItemsView(settings.arguments));

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
