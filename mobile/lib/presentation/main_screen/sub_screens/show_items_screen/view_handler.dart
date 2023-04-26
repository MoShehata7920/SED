// ignore_for_file: constant_identifier_names
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import '../../../resources/icons_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';
import 'viewmodel/show_items_screen_viewmodel.dart';

enum Views { SELL, DONATE, EXCHANGE, CATEGORY, SAVED, SEARCHIMAGE }

extension ViewExtension on Views {
  String getName({int categoryId = 0}) {
    switch (this) {
      case Views.SELL:
        return ViewsName.sell;

      case Views.DONATE:
        return ViewsName.donate;

      case Views.EXCHANGE:
        return ViewsName.exchange;

      case Views.CATEGORY:
        return Utils.getCategoryNameById(categoryId);

      case Views.SAVED:
        return ViewsName.saved;

      case Views.SEARCHIMAGE:
        return "Search Image";
    }
  }

  Widget getCard(Items item, BuildContext context) {
    return SizedBox(height: 250, child: ViewCard.getCard(item, context));
  }

  int getViewId() {
    switch (this) {
      case Views.SELL:
        return 0;
      case Views.DONATE:
        return 1;
      case Views.EXCHANGE:
        return 2;
      case Views.CATEGORY:
        return 3;
      case Views.SAVED:
        return 4;
      case Views.SEARCHIMAGE:
        return 5;
    }
  }
}

class ViewsName {
  static String sell = AppStrings.sell;
  static String donate = AppStrings.donate;
  static String exchange = AppStrings.exchange;
  static String saved = AppStrings.saved;
}

class ViewCard {
  static Widget getCard(Items item, BuildContext context) {
    final HomeScreenViewModel homeScreenViewModel =
        instance<HomeScreenViewModel>();

    final ShowItemsViewModel showItemsViewModel =
        instance<ShowItemsViewModel>();

    return InkWell(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
        color: ColorsManager.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                width: AppSize.s200,
                height: AppSize.s200,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.network(
                      item.image,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            homeScreenViewModel.toggleSavingProduct(item);
                          },
                          icon: StreamBuilder<bool>(
                              stream: homeScreenViewModel.savedOutput,
                              builder: (context, snapshot) {
                                return CircleAvatar(
                                  radius: AppSize.s14,
                                  backgroundColor: item.isSaved
                                      ? ColorsManager.primaryColor
                                      : ColorsManager.grey2,
                                  child: Icon(
                                    Icons.favorite_border,
                                    size: AppSize.s12,
                                    color: ColorsManager.white,
                                  ),
                                );
                              })),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                      child: Text(
                        item.category,
                        style: TextStyle(
                          fontSize: AppSize.s10,
                          color: ColorsManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p8),
              child: Text(
                item.name,
                maxLines: AppValues.maxItemNameLines,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p10),
              child: Icon(
                Icons.attach_money,
                color: ColorsManager.primaryColor,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      IconsManager.location,
                      size: AppSize.s12,
                      color: ColorsManager.grey2,
                    ),
                    Expanded(
                      child: Text(
                        'Gharbiya / Tanta',
                        textAlign: TextAlign.start,
                        maxLines: AppValues.maxAddressLines,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: AppSize.s12, color: ColorsManager.grey2),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.date,
                        textAlign: TextAlign.end,
                        maxLines: AppValues.maxDateLines,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: AppSize.s12, color: ColorsManager.grey2),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, Routes.itemScreenRoute,
            arguments: item.id);
      },
    );
  }
}
