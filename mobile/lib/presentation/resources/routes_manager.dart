import 'package:flutter/material.dart';
import 'package:sed/presentation/login/login_view.dart';
import 'package:sed/presentation/onboarding/onboarding_view.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import '../splash/splash_view.dart';

class Routes {
  static const String splashRoute = "/";
  static const String onBoardingRoute = "/onboarding";
  static const String loginRoute = "/login";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());

      case Routes.onBoardingRoute:
        return MaterialPageRoute(builder: (context) => const OnBoardingView());

      case Routes.loginRoute:
        return MaterialPageRoute(builder: (context) => const LoginView());

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
