import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/constants_manager.dart';

import '../resources/routes_manager.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _initTimers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backGroundLightPrimary,
      body: const Center(
        child: Image(
          image: AssetImage(ImageAssets.lightModeSplashLogo),
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

  void _onFinishLoading() => Navigator.pushReplacementNamed(context,Routes.onBoardingRoute);
}
