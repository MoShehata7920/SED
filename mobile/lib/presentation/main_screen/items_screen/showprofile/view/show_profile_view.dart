import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
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
      backgroundColor: ColorManager.lightGrey,
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    ColorManager.secondLightPrimary,
                    ColorManager.thirdLightPrimary
                  ])),
        ),
        toolbarHeight: 50,
        actions: [Icon(Icons.report)],
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
          Container(
            color: ColorManager.white,
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
                          Text(
                            userData.name,
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorManager.thirdLightPrimary),
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                userData.phone,
                                style: TextStyle(
                                    fontSize: 13, color: ColorManager.grey2),
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
          SizedBox(
            height: 3,
          ),
          Container(
            width: double.infinity,
            color: ColorManager.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Published Items (${_viewModel.showProfileProducts.length})",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.secondLightPrimary),
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
        color: ColorManager.white,
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
                      _viewModel.showProfileProducts[index].image,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            homeScreenViewModel
                                .toggleSavingProduct(_viewModel.showProfileProducts[index]);

                          },
                          icon: StreamBuilder<bool>(
                              stream: homeScreenViewModel.savedOutput,
                              builder: (context, snapshot) {
                                return CircleAvatar(
                                  radius: 14,
                                  backgroundColor:
                                  _viewModel.showProfileProducts[index].isSaved
                                      ? ColorManager.thirdLightPrimary
                                      : ColorManager.grey2,
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                );
                              })),
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.5),
                      padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                      child: Text(
                        Utils.getCategoryNameById(
                            _viewModel.showProfileProducts[index].categoryId),
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
                _viewModel.showProfileProducts[index].name,
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
                        _viewModel.showProfileProducts[index].date,
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
            arguments: _viewModel.showProfileProducts[index].id);
      },
    );
  }
}
