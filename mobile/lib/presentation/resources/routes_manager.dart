import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/splash/splash_view.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

class Routes {
  static const String splashRoute = "/";
}

class RouteGenerator {

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splashRoute:
        return MaterialPageRoute(builder: (context) => const SplashView());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(builder: (context) => Scaffold(
      appBar: AppBar(title: const Text(AppStrings.noRouteTitle),),
      body: const Center(child: Text(AppStrings.noRouteFound)),
    ));
  }

}