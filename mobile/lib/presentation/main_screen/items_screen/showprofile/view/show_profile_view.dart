import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/items_screen/showprofile/viewmodel/show_profile_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

class ShowProfileView extends StatefulWidget {

  Object? userData;

  ShowProfileView(this.userData, {Key? key}) : super(key: key);

  @override
  State<ShowProfileView> createState() => _ShowProfileViewState(userData as UserData);
}

class _ShowProfileViewState extends State<ShowProfileView> {
  UserData userData;

  _ShowProfileViewState(this.userData);

  final ShowProfileViewModel _viewModel = ShowProfileViewModel();

  void _bind() {
    _viewModel.start();

    _viewModel.getShowProfile(userData.id);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.primaryBackground,
        toolbarHeight: 50,
        actions: [Padding(
          padding: const EdgeInsets.all(15.0),
          child: FaIcon(FontAwesomeIcons.exclamation),
        )],
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () => _viewModel.getShowProfile(userData.id)) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorsManager.secondaryBackground,
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: AppSize.s32,
                        backgroundImage: NetworkImage(
                            userData.image),
                      ),
                      const SizedBox(
                        width: AppSize.s14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: AppSize.s8,
                            ),
                            Text(
                              userData.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                  fontSize: AppSize.s18,
                                  color: ColorsManager.white),
                            ),
                            const SizedBox(
                              height: AppSize.s15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  userData.phone,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                      fontSize: AppSize.s14,
                                      color: ColorsManager.secondaryText),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(
            height: 3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: ColorsManager.secondaryBackground,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    "Published Items (${_viewModel.showProfileProducts.length})",
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(
                        fontSize: AppSize.s16,
                        color: ColorsManager.secondaryText),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 3,),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: AppValues.showItemCrossAxisCounts,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(_viewModel.showProfileProducts.length,
                    (index) => _getItemWidget(index)),
          ),
        ]),
      );
  }

  Widget _getItemWidget(int index) {
    final HomeScreenViewModel homeScreenViewModel =
    instance<HomeScreenViewModel>();

    return InkWell(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
        color: ColorsManager.secondaryBackground,
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: AppSize.s200,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(AppSize.s16),
                              topRight: Radius.circular(AppSize.s16)),
                          image: DecorationImage(
                            image: NetworkImage(
                              _viewModel.showProfileProducts[index].image,
                            ),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                            onPressed: () {
                              homeScreenViewModel
                                  .toggleSavingProduct(
                                  _viewModel.showProfileProducts[index]);
                            },
                            icon: StreamBuilder<bool>(
                                stream: homeScreenViewModel.savedOutput,
                                builder: (context, snapshot) {
                                  return CircleAvatar(
                                    radius: AppSize.s14,
                                    backgroundColor:
                                    _viewModel.showProfileProducts[index]
                                        .isSaved
                                        ? ColorsManager.primaryColor
                                        : ColorManager.grey2,
                                    child: Icon(
                                      Icons.favorite_border,
                                      size: AppSize.s12,
                                      color: ColorsManager.white,
                                    ),
                                  );
                                })),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p6),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppPadding.p5),
                          child: Text(
                            Utils.getCategoryNameById(
                                _viewModel.showProfileProducts[index]
                                    .categoryId),
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                fontSize: AppSize.s12,
                                color: ColorsManager.secondaryText),
                          ),
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
                _viewModel.showProfileProducts[index].name,
                maxLines: AppValues.maxItemNameLines,
                overflow: TextOverflow.ellipsis,
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                    fontSize: AppSize.s15,
                    color: ColorsManager.secondaryText,
                    height: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p10),
              child: Text(
                getPrice(_viewModel.showProfileProducts[index].price),
                style: Theme
                    .of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(
                    fontSize: 15,
                    color: ColorsManager.secondaryText,
                    height: 1),
              ),
            ),
            const SizedBox(
              height: AppSize.s15,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
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
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
                            fontSize: AppSize.s12, color: ColorsManager.grey2),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _viewModel.showProfileProducts[index].date,
                        textAlign: TextAlign.end,
                        maxLines: AppValues.maxDateLines,
                        overflow: TextOverflow.ellipsis,
                        style: Theme
                            .of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(
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
            arguments: _viewModel.showProfileProducts[index].id);
      },
    );
  }
}
