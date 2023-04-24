import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/items_screen/showprofile/viewmodel/show_profile_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

// ignore: must_be_immutable
class ShowProfileView extends StatefulWidget {
  Object? userData;

  ShowProfileView(this.userData, {Key? key}) : super(key: key);

  @override
  // ignore: no_logic_in_create_state
  State<ShowProfileView> createState() =>
      _ShowProfileViewState(userData as UserData);
}

class _ShowProfileViewState extends State<ShowProfileView> {
  UserData userData;

  _ShowProfileViewState(this.userData);

  final ShowProfileViewModel _viewModel = ShowProfileViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ShowItemsContentObject>(
        stream: _viewModel.contentOutput,
        builder: (context, snapshot) {
          return _buildWidget(snapshot.data);
        });
  }

  Widget _buildWidget(ShowItemsContentObject? showItemsContentObject) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.primaryBackground,
        toolbarHeight: AppSize.s50,
        actions: const [
          Padding(
            padding: EdgeInsets.all(AppPadding.p15),
            child: FaIcon(FontAwesomeIcons.exclamation),
          )
        ],
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context,
                  _getContentWidget(showItemsContentObject),
                  () => _viewModel.getShowProfile(userData.id)) ??
              _getContentWidget(showItemsContentObject);
        },
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  void _bind() {
    _viewModel.start();

    _viewModel.getShowProfile(userData.id);
  }

  Widget _getContentWidget(ShowItemsContentObject? showItemsContentObject) {
    if (showItemsContentObject == null) {
      return Container();
    } else {
      return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          const SizedBox(height: AppSize.s5),
          Padding(
            padding: const EdgeInsets.all(AppSize.s20),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s20)),
                color: ColorsManager.secondaryBackground,
              ),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(AppSize.s10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: AppSize.s32,
                        backgroundImage: NetworkImage(userData.image),
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
                                      color: ColorsManager.primaryText),
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
          const SizedBox(
            height: AppSize.s3,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p25),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s20)),
                color: ColorsManager.secondaryBackground,
              ),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppPadding.p10),
                child: Center(
                  child: Text(
                    "Published Items (${showItemsContentObject.items.length})",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: AppSize.s16,
                        color: ColorsManager.secondaryText),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: AppSize.s3,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: AppValues.showItemCrossAxisCounts,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(showItemsContentObject.items.length,
                (index) => _getItemWidget(index, showItemsContentObject)),
          ),
        ]),
      );
    }
  }

  Widget _getItemWidget(
      int index, ShowItemsContentObject showItemsContentObject) {
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
                              showItemsContentObject.items[index].image,
                            ),
                            fit: BoxFit.fill,
                          )),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            homeScreenViewModel.toggleSavingProduct(
                                showItemsContentObject.items[index]);
                          },
                          icon: StreamBuilder<bool>(
                              stream: homeScreenViewModel.savedOutput,
                              builder: (context, snapshot) {
                                return CircleAvatar(
                                  radius: AppSize.s14,
                                  backgroundColor: showItemsContentObject
                                          .items[index].isSaved
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
                    Padding(
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
                          showItemsContentObject.items[index].category,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: AppSize.s12,
                                  color: ColorsManager.secondaryText),
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
                showItemsContentObject.items[index].name,
                maxLines: AppValues.maxItemNameLines,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: AppSize.s15,
                    color: ColorsManager.secondaryText,
                    height: 1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.p10),
              child: Text(
                getPrice(showItemsContentObject.items[index].price),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
                      color: ColorsManager.grey2,
                    ),
                    Expanded(
                      child: Text(
                        'Gharbiya / Tanta',
                        textAlign: TextAlign.start,
                        maxLines: AppValues.maxAddressLines,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: AppSize.s12, color: ColorsManager.grey2),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        showItemsContentObject.items[index].date,
                        textAlign: TextAlign.end,
                        maxLines: AppValues.maxDateLines,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
            arguments: showItemsContentObject.items[index].id);
      },
    );
  }
}
