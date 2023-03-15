import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.start();
    });

    super.initState();
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<GetMyProfileAds>(
        stream: _viewModel.contentOutput,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(GetMyProfileAds? getMyProfileAds) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: AppSize.s50,
        title: Text(
          AppStrings.myAds.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.lineColor,
                fontSize: AppSize.s30,
              ),
        ),
        backgroundColor: ColorsManager.primaryBackground,
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                    context, _getContent(getMyProfileAds), () => () {}) ??
                _getContent(getMyProfileAds);
          }),
    );
  }

  Widget _getContent(GetMyProfileAds? getMyProfileAds) {
    if (getMyProfileAds == null) {
      return Container();
    } else {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(
              height: AppSize.s10,
            ),
            ListView.builder(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: getMyProfileAds.items.length,
              itemBuilder: (context, index) =>
                  _getProduct(getMyProfileAds.items[index]),
            ),
          ],
        ),
      );
    }
  }

  Widget _getProduct(Items item) {
    return Center(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            decoration: BoxDecoration(
              color: ColorsManager.secondaryBackground,
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            child: Material(
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsetsDirectional.all(AppPadding.p10),
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
                              width: AppSize.s100,
                              height: AppSize.s100,
                              decoration: BoxDecoration(
                                  color: ColorsManager.secondaryBackground,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(AppSize.s8),
                                      bottomLeft: Radius.circular(AppSize.s8)),
                                  image: DecorationImage(
                                    image: NetworkImage(item.image),
                                    fit: BoxFit.fill,
                                  )),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(AppSize.s8)),
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
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding:
                              const EdgeInsetsDirectional.all(AppPadding.p10),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Text(
                                  item.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: ColorsManager.primaryText,
                                        fontSize: AppSize.s18,
                                      ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(AppPadding.p8),
                                child: Text(
                                  getPrice(item.price),
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
                                item.date,
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
                            IconsManager.update,
                            color: ColorsManager.primaryColor,
                            size: AppSize.s20,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.addProductScreenRoute,
                                arguments: [item.categoryId - 1, item]);
                          },
                        ),
                        IconButton(
                          splashColor: ColorsManager.primaryColor,
                          icon: Icon(
                            IconsManager.delete,
                            color: ColorsManager.primaryColor,
                            size: AppSize.s20,
                          ),
                          onPressed: () {
                            _viewModel.inputState.add(ConfirmationState(
                                StateRendererType.popUpConfirmationState,
                                "Are you sure that you want to delete ${item.name} ?",
                                "",
                                () => _viewModel.removeAd(item.id)));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s10,
          ),
        ],
      ),
    );
  }
}
