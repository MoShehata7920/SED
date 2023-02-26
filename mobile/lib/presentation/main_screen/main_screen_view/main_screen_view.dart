import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/main_screen/main_screen_viewmodel/main_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';

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
            backgroundColor: Colors.white,
            body: snapshot.data ??
                _viewModel.mainScreenWidgets[0], //destination screen
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorManager.white,
              child: Icon(
                Icons.add,
                color: ColorManager.black,
              ),
              onPressed: () {},
              //params
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar(
              icons: IconsManager.iconsList,
              activeIndex: _viewModel.bottomNavIndex,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              leftCornerRadius: 32,
              rightCornerRadius: 32,
              onTap: (index) => _viewModel.onIndexChange(index),

              //other params
            ),
          );
        });
  }
}
