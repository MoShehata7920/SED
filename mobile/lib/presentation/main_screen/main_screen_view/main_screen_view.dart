import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/main_screen/main_screen_viewmodel/main_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class MainScreenView extends StatefulWidget {
  const MainScreenView({super.key});

  @override
  State<MainScreenView> createState() => _MainScreenViewState();
}

class _MainScreenViewState extends State<MainScreenView> {
  final MainScreenViewModel _viewModel = instance<MainScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Widget>(
        stream: _viewModel.mainViewOutput,
        builder: (context, snapshot) {
          return Scaffold(
            extendBody: true,

            backgroundColor: ColorManager.white,
            body: snapshot.data ??
                _viewModel.mainScreenWidgets[0], //destination screen
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorManager.lightPrimary,
              child: Container(
                width: AppSize.s60,
                height: AppSize.s60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: ColorManager.firstLightPrimaryMix),
                child: const Icon(
                  Icons.add,
                ),
              ),
              onPressed: () {},
              //params
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              // borderColor: Colors.transparent,
              inactiveColor: ColorManager.white,
              activeColor: ColorManager.fifthLightPrimary,
              backgroundGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    ColorManager.secondLightPrimary,
                    ColorManager.thirdLightPrimary
                  ]),
              icons: IconsManager.iconsList,
              activeIndex: _viewModel.bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              onTap: (index) => _viewModel.onIndexChange(index),

              //other params
            ),
          );
        });
  }
}
