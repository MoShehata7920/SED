import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/forgot_password/view/forgot_password.dart';
import 'package:sed/presentation/login/view/login_view.dart';
import 'package:sed/presentation/main_screen/main_screen_view.dart';
import 'package:sed/presentation/onboarding/view/onboarding_view.dart';
import 'package:sed/presentation/register/view/register.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
  static const String forgotPasswordRoute = "/forgotPassword";
  static const String registerRoute = "/register";
  static const String mainScreenRoute = "/main";
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
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordView());

      case Routes.registerRoute:
        return MaterialPageRoute(builder: (context) => const RegisterView());

      case Routes.mainScreenRoute:
        return MaterialPageRoute(builder: (context) => const MainScreenView());

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
