import 'package:convex_bottom_bar/convex_bottom_bar.dart';
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
  void initState() {
    _viewModel.start();

    super.initState();
  }

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
              bottomNavigationBar: ConvexAppBar.badge(
                {1: '5'},
                badgeMargin: const EdgeInsets.only(
                    left: AppPadding.p14, bottom: AppPadding.p14),
                activeColor: ColorsManager.secondaryText,
                backgroundColor: ColorsManager.primaryBackground,
                items: IconsManager.iconsList,
                onTap: (int i) => _viewModel.onIndexChange(i),
                style: TabStyle.flip,
              ));
        });
  }
}
