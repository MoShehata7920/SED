import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';

class MyAdsScreenView extends StatefulWidget {
  const MyAdsScreenView({super.key});

  @override
  State<MyAdsScreenView> createState() => _MyAdsScreenViewState();
}

class _MyAdsScreenViewState extends State<MyAdsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: AppSize.s50,
        title: Text(
          AppStrings.myAds,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.lineColor,
                fontSize: AppSize.s30,
              ),
        ),
        backgroundColor: ColorsManager.primaryBackground,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            _getContentWidget(
                "https://th.bing.com/th/id/R.cfd767375ca4875e8ea6cce2afdb7c12?rik=BbzHzFqMxbCKTg&pid=ImgRaw&r=0",
                "Oppo f7",
                "1500",
                "2/12/2022"),
            SizedBox(
              height: 25,
            ),
            _getContentWidget(
                "https://th.bing.com/th/id/R.29ec85ffd91eb1775cb57f45d66354bf?rik=uGlxfhiBCzH6RA&pid=ImgRaw&r=0",
                "SHOES",
                "190",
                "5/1/2023"),
          ],
        ),
      ),
    );
  }

  Widget _getContentWidget(
      String image, String productName, String price, String date) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 120,
        decoration: BoxDecoration(
          color: ColorsManager.secondaryBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Stack(
                    alignment: Alignment.topLeft,
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            color: ColorsManager.secondaryBackground,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSize.s8),
                                bottomLeft: Radius.circular(AppSize.s8)),
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.fill,
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(8.0)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSize.s5, vertical: AppSize.s2),
                          child: Text(
                            "Sell",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    fontSize: AppSize.s12,
                                    color: ColorsManager.primaryText),
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.all(10),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productName,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsManager.primaryText,
                                    fontSize: AppSize.s18,
                                  ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            price,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorsManager.secondaryText,
                                      fontSize: AppSize.s14,
                                    ),
                          ),
                        ),
                        // Spacer(),
                        Text(
                          date,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsManager.grey,
                                    fontSize: AppSize.s12,
                                  ),
                          textAlign: TextAlign.end,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    // borderColor: Colors.transparent,
                    // borderRadius: 30,
                    // buttonSize: 48,
                    icon: Icon(
                      Icons.edit_outlined,
                      color: ColorsManager.primaryColor,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    // borderColor: Colors.transparent,
                    // borderRadius: 30,
                    // buttonSize: 48,
                    icon: Icon(
                      Icons.delete,
                      color: ColorsManager.primaryColor,
                      size: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
