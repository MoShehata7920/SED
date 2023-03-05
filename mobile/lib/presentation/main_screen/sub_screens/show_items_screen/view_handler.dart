// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import '../../../resources/icons_manager.dart';
import '../../../resources/values_manager.dart';

enum Views { SELL, DONATE, EXCHANGE, CATEGORY, SAVED }

extension ViewExtension on Views {
  String getName() {
    switch (this) {
      case Views.SELL:
        return ViewsName.sell;

      case Views.DONATE:
        return ViewsName.donate;

      case Views.EXCHANGE:
        return ViewsName.exchange;

      case Views.CATEGORY:
        return ViewsName.category;

      case Views.SAVED:
        return ViewsName.saved;
    }
  }

  Widget getCard(Items item, BuildContext context) {
    return ViewCard.getCard(item, context);
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
    }
  }
}

class ViewsName {
  static const String sell = "Sell";
  static const String donate = "Donate";
  static const String exchange = "Exchange";
  static String category = getCategoryName();
  static String saved = "Saved";
}

class ViewCard {
  static Widget getCard(Items item, BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
        color: ColorManager.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                width: AppSize.s150,
                height: AppSize.s150,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.network(
                      item.image,
                      fit: BoxFit.contain,
                      width: double.infinity,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                      child: Text(
                        Utils.getCategoryNameById(item.categoryId),
                        style: TextStyle(
                          fontSize: AppSize.s10,
                          color: ColorManager.white,
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
                color: ColorManager.lightPrimary,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      IconsManager.location,
                      size: AppSize.s12,
                      color: ColorManager.grey2,
                    ),
                    Expanded(
                      child: Text(
                        'Gharbiya / Tanta',
                        textAlign: TextAlign.start,
                        maxLines: AppValues.maxAddressLines,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: AppSize.s12, color: ColorManager.grey2),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        item.date,
                        textAlign: TextAlign.end,
                        maxLines: AppValues.maxDateLines,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: AppSize.s12, color: ColorManager.grey2),
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

String getCategoryName() {
  return "hello world";
}
