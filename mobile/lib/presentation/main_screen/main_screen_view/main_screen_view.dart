import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/main_screen/main_screen_viewmodel/main_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
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
            backgroundColor: ColorsManager.darkBlack,
            body: snapshot.data ??
                _viewModel.mainScreenWidgets[0], //destination screen
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorsManager.darkBlack,
              child: Container(
                width: AppSize.s60,
                height: AppSize.s60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorsManager.primaryBackground),
                child: const Icon(IconsManager.add),
              ),
              onPressed: () {
                Navigator.pushNamed(context, Routes.categoriesScreenRoute);
              },
              //params
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: AnimatedBottomNavigationBar.builder(
              itemCount: 4,
              tabBuilder: (index, isSelected) {
                final iconData = IconsManager.iconsList[index];
                final selectedColor = ColorsManager.primaryColor;
                final unselectedColor = ColorsManager.primaryText;

                if(index == 1) {
                  return Center(
                    child: Badge(
                      label: Text('+99'),
                      child: Icon(iconData,
                        color: isSelected ? selectedColor : unselectedColor,
                      ),
                    ),
                  );
                }
                return Icon(iconData,
                  color: isSelected ? selectedColor : unselectedColor,
                );
              },
              activeIndex: _viewModel.bottomNavIndex,
              onTap: (index) => _viewModel.onIndexChange(index),
              height: 60,
              gapLocation: GapLocation.center,
              notchSmoothness: NotchSmoothness.verySmoothEdge,
              backgroundColor: ColorsManager.primaryBackground, // Set the background color to primary background color
            ),
          );
        });
  }
}
