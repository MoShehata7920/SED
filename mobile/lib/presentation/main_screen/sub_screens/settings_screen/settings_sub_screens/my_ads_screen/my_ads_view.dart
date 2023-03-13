import 'package:flutter/material.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';
import 'my_ads_viewmodel.dart';

class MyAdsScreenView extends StatefulWidget {
  const MyAdsScreenView({super.key});

  @override
  State<MyAdsScreenView> createState() => _MyAdsScreenViewState();
}

class _MyAdsScreenViewState extends State<MyAdsScreenView> {
  final MyAdsViewModel _viewModel = MyAdsViewModel();

  @override
  void initState() {
    _viewModel.start();

    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data
                ?.getScreenWidget(context, _getContentWidget(), () {}) ??
            _getContentWidget();
      },
    );
  }

  Widget _getContentWidget() => Scaffold(
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
        body: StreamBuilder<GetMyProfileData>(
            stream: _viewModel.contentOutput,
            builder: (context, snapshot) {
              return _getContent(snapshot.data);
            }),
      );

  Widget _getContent(GetMyProfileData? getMyProfileData) {
    if (getMyProfileData == null) {
      return Container();
    } else {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) => _getProduct(getMyProfileData),
            ),
          ],
        ),
      );
    }
  }

  Widget _getProduct(GetMyProfileData? getMyProfileData) {
    if (getMyProfileData == null) {
      return Container();
    } else {
      return Center(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 120,
              decoration: BoxDecoration(
                color: ColorsManager.secondaryBackground,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Material(
                color: Colors.transparent,
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
                                        bottomLeft:
                                            Radius.circular(AppSize.s8)),
                                    image: DecorationImage(
                                      image: NetworkImage("image"),
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
                                      horizontal: AppSize.s5,
                                      vertical: AppSize.s2),
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
                                  "productName",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: ColorsManager.primaryText,
                                        fontSize: AppSize.s18,
                                      ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "price",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: ColorsManager.secondaryText,
                                          fontSize: AppSize.s14,
                                        ),
                                  ),
                                ),
                                // Spacer(),
                                Text(
                                  "date",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
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
                            splashColor: ColorsManager.primaryColor,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: ColorsManager.primaryColor,
                              size: 20,
                            ),
                            onPressed: () {},
                          ),
                          IconButton(
                            splashColor: ColorsManager.primaryColor,
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
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      );
    }
  }
}
