import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/animation_manager/animation_,manager.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/styles_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  final CarouselController _controller = CarouselController();

  final HomeScreenViewModel _viewModel = instance<HomeScreenViewModel>();

  final ScrollController _listViewScrollController = ScrollController();

  int selectedIndex = 0;

  void _bind() {
    _viewModel.start();

    _viewModel.getHomeData();
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
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: FaIcon(
                FontAwesomeIcons.barsStaggered,
                color: ColorsManager.secondaryText,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            ).animateOnPageLoad(msDelay: 1, dx: 0, dy: -57, showDelay: 900);
          },
        ),
        toolbarHeight: AppSize.s50,
        title: SizedBox(
          width: double.infinity,
          height: AppSize.s40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: AppSize.s14,
              ),
              FaIcon(
                FontAwesomeIcons.bell,
                color: ColorsManager.secondaryText,
              )
            ],
          ).animateOnPageLoad(msDelay: 150, dx: 0, dy: -57, showDelay: 900),
        ),
        flexibleSpace: Container(),
        backgroundColor: ColorsManager.primaryBackground,
      ),
      drawer: Drawer(
        child: GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // crossAxisCount is the number of columns
          crossAxisCount: AppValues.categoriesCrossAxisCount,
          // This creates two columns with two items in each column
          children: List.generate(
              Utils.categories.length > AppValues.defaultCategoriesNumber
                  ? AppValues.defaultCategoriesNumber
                  : Utils.categories.length, (index) {
            return Center(
              child: InkWell(
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p14),
                          child: Image(
                            image: NetworkImage(Utils.categories[index].image),
                            fit: BoxFit.fill,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppPadding.p8),
                        child: Text(
                          Utils.categories[index].name,
                          maxLines: AppValues.maxItemNameLines,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pushNamed(context, Routes.showItemsScreenRoute,
                      arguments: [Views.CATEGORY, Utils.categories[index].id]);
                },
              ),
            );
          }),
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () => _viewModel.getHomeData()) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<void>(
        stream: _viewModel.carouselOutput,
        builder: (context, snapshot) {
          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSize.s20),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Hi Alex, Let\'s',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(fontSize: 24, color: ColorsManager.white),
                    ),
                  ),
                  const SizedBox(height: AppSize.s10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      'Find your favorite product',
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 19,
                            color: ColorsManager.secondaryText,
                          ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 36, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
                            child: Container(
                              width: 100,
                              height: 55,
                              decoration: BoxDecoration(
                                color: ColorsManager.secondaryBackground,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    15, 0, 15, 0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.magnifyingGlass,
                                      color: ColorsManager.secondaryText,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: TextFormField(
                                        obscureText: false,
                                        decoration: InputDecoration(
                                          hintText: 'Search here ...',
                                          filled: true,
                                          fillColor:
                                              ColorsManager.secondaryBackground,
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                              color:
                                                  ColorsManager.primaryBtnText,
                                              fontSize: 15,
                                            ),
                                      ),
                                    ),
                                    FaIcon(
                                      FontAwesomeIcons.calendarMinus,
                                      color: ColorsManager.secondaryText,
                                      size: 24,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s25,
                  ),
                  CarouselSlider(
                    carouselController: _controller,
                    options: CarouselOptions(
                        aspectRatio: AppValues.carouselAspectRatio,
                        height: AppSize.s200,
                        autoPlay: true,
                        autoPlayInterval: const Duration(
                            seconds: AppValues.carouselAutoPlayInterval),
                        onPageChanged: (index, reason) {
                          _viewModel.onPageChanged(index);
                        }),
                    items: _viewModel.carouselImages.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                                horizontal: AppPadding.p4),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      NetworkImage(image ?? AppStrings.empty),
                                  fit: BoxFit.cover),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(AppSize.s16)),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 25, left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Top Categories',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsManager.lineColor,
                                    fontSize: 13,
                                  ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Categories',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: ColorsManager.white,
                                    fontSize: 21,
                                  ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.categoriesScreenRoute);
                                },
                                child: Text(
                                  'See more',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: ColorsManager.primaryBtnText,
                                        fontSize: 13,
                                      ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: AppSize.s100,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 6,
                      itemBuilder: (context, index) =>
                          _getCategoryWidget(index),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      height: 2,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, bottom: 20),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          for (int i = 0; i < 3; i++)
                            _getButtonWidget(Utils.sections[i]!, i)
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5, left: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Last Products',
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsManager.lineColor,
                                    fontSize: 13,
                                  ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              Utils.sections[selectedIndex]!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    color: ColorsManager.white,
                                    fontSize: 21,
                                  ),
                            ),
                            TextButton(
                                onPressed: () {
                                  Views viewType = Views.SELL;

                                  if (selectedIndex == 1) {
                                    viewType = Views.EXCHANGE;
                                  } else if (selectedIndex == 2) {
                                    viewType = Views.DONATE;
                                  }

                                  Navigator.pushNamed(context, Routes.showItemsScreenRoute,
                                      arguments: [viewType, 0]);
                                },
                                child: Text(
                                  'See more',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: ColorsManager.primaryBtnText,
                                        fontSize: 13,
                                      ),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  _getItems(selectedIndex, _viewModel),

                  // Padding(
                  //   padding: const EdgeInsets.all(AppPadding.p10),
                  //   child: Image(
                  //     height: AppSize.s150,
                  //     width: double.infinity,
                  //     fit: BoxFit.fill,
                  //     image: NetworkImage(
                  //       //TODO default image
                  //       _viewModel.sections.isNotEmpty
                  //           ? _viewModel.sections[1].image
                  //           : "",
                  //     ),
                  //   ),
                  // ),
                  //
                  // for (int i = 0; i < 3; i++)
                  //   _getItems(1, _viewModel, context)[i],
                  //
                  // Padding(
                  //   padding: const EdgeInsets.all(AppPadding.p10),
                  //   child: Image(
                  //     height: AppSize.s150,
                  //     fit: BoxFit.fill,
                  //     width: double.infinity,
                  //     image: NetworkImage(
                  //       //TODO default image
                  //       _viewModel.sections.isNotEmpty
                  //           ? _viewModel.sections[2].image
                  //           : "",
                  //     ),
                  //   ),
                  // ),
                  //
                  // for (int i = 0; i < 3; i++)
                  //   _getItems(2, _viewModel, context)[i],

                  const SizedBox(
                    height: AppSize.s100,
                  )
                  //preparing for the next widget maybe ?
                ],
              ),
            ),
          );
        });
  }

  Future _onRefresh() async {
    _viewModel.getHomeData();
  }

  Widget _getCategoryWidget(int index) {
    return InkWell(
      child: Column(
        children: [
          Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
                color: ColorsManager.secondaryBackground,
                shape: BoxShape.circle),
            child: Center(
              child: FaIcon(
                IconsManager.categoriesIcons[index],
                color: ColorsManager.secondaryText,
              ),
            ),
          ),
          const SizedBox(
            width: 100,
            height: 10,
          ),
          Text(
            Utils.categories[index].name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorsManager.secondaryText,
                  fontSize: 13,
                ),
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, Routes.showItemsScreenRoute,
            arguments: [Views.CATEGORY, Utils.categories[index].id]);
      },
    );
  }

  Widget _getButtonWidget(String Name, int index) {
    return InkWell(
      child: Row(
        children: [
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: selectedIndex == index
                  ? ColorsManager.primaryColor
                  : ColorsManager.primaryBackground,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(
                color: ColorsManager.secondaryBackground,
                width: selectedIndex == index ? 0 : 3,
              ),
            ),
            alignment: const AlignmentDirectional(0, 0),
            child: Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
              child: Text(
                Name,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: selectedIndex == index
                          ? ColorsManager.primaryBackground
                          : ColorsManager.secondaryText,
                      fontSize: 17,
                    ),
              ),
            ),
          ),
          SizedBox(
            width: 15,
          )
        ],
      ),
      onTap: () {
        setState(() {
          _listViewScrollController.animateTo(
              _listViewScrollController.position.minScrollExtent,
              duration: const Duration(milliseconds: 1),
              curve: Curves.bounceIn);
          selectedIndex = index;
        });
      },
    );
  }

  Widget _getItems(int sectionId, HomeScreenViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: SizedBox(
        height: AppSize.s270,
        child: ListView.builder(
          controller: _listViewScrollController,
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: sectionId == 0
              ? viewModel.sellItems.length
              : sectionId == 1
                  ? viewModel.donateItems.length
                  : viewModel.exchangeItems.length,
          itemBuilder: (context, index) => _buildItem(
              sectionId == 0
                  ? viewModel.sellItems[index]
                  : sectionId == 1
                      ? viewModel.donateItems[index]
                      : viewModel.exchangeItems[index],
              sectionId,
              viewModel,
              context),
        ),
      ),
    );
  }
}

Widget _buildItem(Items item, int sectionId,
    HomeScreenViewModel homeScreenViewModel, BuildContext context) {
  return SizedBox(
    width: AppSize.s200,
    child: InkWell(
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s16)),
        color: ColorsManager.secondaryBackground,
        child: Column(
          children: [
            Flexible(
              flex: 2,
              child: SizedBox(
                width: AppSize.s200,
                height: AppSize.s200,
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
                              item.image,
                            ),
                            fit: BoxFit.fill,
                          )),
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
                                  radius: 14,
                                  backgroundColor: item.isSaved
                                      ? ColorsManager.primaryColor
                                      : ColorManager.grey2,
                                  child: const Icon(
                                    Icons.favorite_border,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                );
                              })),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.all(Radius.circular(16.0)),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p5),
                        child: Text(
                          Utils.getCategoryNameById(item.categoryId),
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 12,
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
                item.name,
                maxLines: AppValues.maxItemNameLines,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 15, color: ColorsManager.secondaryText),
              ),
            ),
            if (sectionId == 0)
              Padding(
                padding: const EdgeInsets.only(top: AppPadding.p10),
                child: Text(
                  getPrice(item.price),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: 15, color: ColorsManager.secondaryText),
                ),
              ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Flexible(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(AppPadding.p10),
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
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 12, color: ColorsManager.grey2),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          item.date,
                          textAlign: TextAlign.end,
                          maxLines: AppValues.maxDateLines,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 12, color: ColorsManager.grey2),
                        ),
                      ),
                    ],
                  ),
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
    ),
  );
}

Widget _getIdentifyBar(String category, BuildContext context, int type) =>
    Container(
      height: AppSize.s40,
      color: ColorManager.lightPrimary.withOpacity(0.1),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: AppSize.s10),
            child: Text(
              category,
              style: getBoldStyle(
                  color: ColorManager.lightPrimary, fontSize: AppSize.s14),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppPadding.p8),
            child: TextButton(
                onPressed: () {
                  Views viewType = Views.CATEGORY;

                  if (type == 1) {
                    viewType = Views.SELL;
                    Navigator.pushNamed(context, Routes.showItemsScreenRoute,
                        arguments: [viewType, 0]);
                  } else if (type == 2) {
                    viewType = Views.DONATE;
                    Navigator.pushNamed(context, Routes.showItemsScreenRoute,
                        arguments: [viewType, 0]);
                  } else if (type == 3) {
                    viewType = Views.EXCHANGE;
                    Navigator.pushNamed(context, Routes.showItemsScreenRoute,
                        arguments: [viewType, 0]);
                  } else {
                    Navigator.pushNamed(context, Routes.categoriesScreenRoute);
                  }
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppStrings.showAll,
                      style: TextStyle(color: ColorManager.lightPrimary),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
