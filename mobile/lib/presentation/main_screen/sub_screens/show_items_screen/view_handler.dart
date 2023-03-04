// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/color_manager.dart';
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

  Widget getCard() {
    return ViewCard.card;
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
  static Widget card = Card(
    elevation: 1,
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSize.s16)),
    color: ColorManager.white,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            width: 150,
            height: 150,
            child: Stack(
              alignment: Alignment.topRight,
              children: [
                Image.network(
                  "https://dietanaluzie.pl/wp-content/uploads/2020/03/img_20200326_173617_898-1.jpg",
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
                Container(
                  color: Colors.black.withOpacity(0.5),
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Text(
                    "Donate",
                    style: TextStyle(
                      fontSize: 10,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            "Rice with milk",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Icon(
            Icons.attach_money,
            color: ColorManager.lightPrimary,
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    "9 mins ago",
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
  );
}

String getCategoryName() {
  return "hello world";
}
