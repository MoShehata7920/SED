import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class CategoriesScreenView extends StatefulWidget {
  const CategoriesScreenView({super.key});

  @override
  State<CategoriesScreenView> createState() => _CategoriesScreenViewState();
}

class _CategoriesScreenViewState extends State<CategoriesScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(IconsManager.close, color: ColorsManager.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppStrings.categories,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.lineColor,
                fontSize: AppSize.s20,
              ),
        ),
        centerTitle: true,
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            for (int i = 0; i < Utils.categories.length; i++)
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: Row(
                    children: [
                      Container(
                        height: AppSize.s45,
                        width: AppSize.s45,
                        decoration: BoxDecoration(
                            color: ColorsManager.secondaryBackground,
                            shape: BoxShape.circle),
                        child: Center(
                          child: FaIcon(
                            IconsManager.categoriesIcons[i],
                            color: ColorsManager.secondaryText,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s20,
                      ),
                      Expanded(
                        child: Text(
                          Utils.categories[i].name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsManager.secondaryText,
                                    fontSize: AppSize.s16,
                                  ),
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.arrowRight,
                        color: ColorsManager.secondaryText,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.addProductScreenRoute,
                      arguments: Utils.categories[i].id);
                },
              ),
          ],
        ),
      ),
    );
  }
}
