import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/common/animation_manager/animation_,manager.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/constants_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void initState() {
    super.initState();
    _initTimers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: AppSize.s60,
            ),
            const Image(
              image: AssetImage(ImageAssets.darkModeSplashLogo),
            ).animateOnPageLoad(msDelay: 150, dx: 0.0, dy: -70.0, showDelay: 900),
            SpinKitSquareCircle(
              color: ColorsManager.primaryColor,
              size: AppSize.s50,
            ).animateOnPageLoad(msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
            Text(
              AppStrings.poweredBy,
              style: Theme.of(context).textTheme.titleMedium,
            ).animateOnPageLoad(msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
            Text(
              AppStrings.eagles,
              style: Theme.of(context).textTheme.bodyLarge,
            ).animateOnPageLoad(msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _initTimers() {
    _timer = Timer(
        const Duration(
          milliseconds: AppConstants.splashLoadingDelay,
        ),
        _onFinishLoading);
  }

  void _onFinishLoading() async {
    _appPreferences.isUserLoggedInSuccessfully().then((isUseLoggedIn) => {
          if (isUseLoggedIn)
            {
              // navigate to main screen
              Navigator.pushReplacementNamed(context, Routes.mainScreenRoute)
            }
          else
            {
              _appPreferences
                  .isOnBoardingScreenViewed()
                  .then((isOnBoardingScreenViewed) => {
                        if (isOnBoardingScreenViewed)
                          {
                            // navigate to Login screen
                            Navigator.pushReplacementNamed(
                                context, Routes.loginRoute)
                          }
                        else
                          {
                            // navigate to onBoarding screen bc it means its the first time he open the app
                            Navigator.pushReplacementNamed(
                                context, Routes.onBoardingRoute)
                          }
                      })
            }
        });
  }
}
