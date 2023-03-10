import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
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
        toolbarHeight: AppSize.s50,
        title: SizedBox(
          width: double.infinity,
          height: AppSize.s40,
          child: Row(
            children: [
              const Icon(Icons.notifications),
              const SizedBox(
                width: AppSize.s14,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: ColorManager.white,
                    hintStyle: TextStyle(color: ColorManager.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppSize.s8),
                      borderSide: BorderSide.none,
                    ),
                    border: InputBorder.none,
                    prefixIconColor: ColorManager.lightPrimary,
                    hintText: AppStrings.searchForSomething,
                    prefixIcon: const Icon(IconsManager.search),
                  ),
                ),
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
        ),
        backgroundColor: ColorsManager.primaryBackground,
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
                children: [
                  const SizedBox(height: AppSize.s20),
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        _viewModel.carouselImages.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: AppSize.s10,
                          height: AppSize.s10,
                          margin: const EdgeInsets.symmetric(
                              vertical: AppPadding.p8,
                              horizontal: AppPadding.p4),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: (ColorsManager.grayIcon)
                                  .withOpacity(
                                      _viewModel.carouselCurrentIndex ==
                                              entry.key
                                          ? AppSize.s0_9
                                          : AppSize.s0_4)),
                        ),
                      );
                    }).toList(),
                  ),
                  _getIdentifyBar(AppStrings.categories, context, 0),

                  const SizedBox(height: AppSize.s10),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p10),
                    child: GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      // crossAxisCount is the number of columns
                      crossAxisCount: AppValues.categoriesCrossAxisCount,
                      // This creates two columns with two items in each column
                      children: List.generate(
                          Utils.categories.length >
                                  AppValues.defaultCategoriesNumber
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
                                      padding:
                                          const EdgeInsets.all(AppPadding.p14),
                                      child: Image(
                                        image: NetworkImage(
                                            Utils.categories[index].image),
                                        fit: BoxFit.fill,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: AppPadding.p8),
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
                              Navigator.pushNamed(
                                  context, Routes.showItemsScreenRoute,
                                  arguments: [
                                    Views.CATEGORY,
                                    Utils.categories[index].id
                                  ]);
                            },
                          ),
                        );
                      }),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image(
                      height: AppSize.s150,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      //todo default image
                      image: NetworkImage(_viewModel.sections.isNotEmpty
                          ? _viewModel.sections[0].image
                          : ""),
                    ),
                  ),

                  for (int i = 0; i < 3; i++)
                    _getItems(0, _viewModel, context)[i],

                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Image(
                      height: AppSize.s150,
                      width: double.infinity,
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        //TODO default image
                        _viewModel.sections.isNotEmpty
                            ? _viewModel.sections[1].image
                            : "",
                      ),
                    ),
                  ),

                  for (int i = 0; i < 3; i++)
                    _getItems(1, _viewModel, context)[i],

                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Image(
                      height: AppSize.s150,
                      fit: BoxFit.fill,
                      width: double.infinity,
                      image: NetworkImage(
                        //TODO default image
                        _viewModel.sections.isNotEmpty
                            ? _viewModel.sections[2].image
                            : "",
                      ),
                    ),
                  ),

                  for (int i = 0; i < 3; i++)
                    _getItems(2, _viewModel, context)[i],

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
}

List<Widget> _getItems(
    int sectionId, HomeScreenViewModel viewModel, BuildContext context) {
  return [
    const SizedBox(height: AppSize.s16),
    _getIdentifyBar(
        sectionId == 0
            ? AppStrings.sell
            : sectionId == 1
                ? AppStrings.donate
                : AppStrings.exchange,
        context,
        sectionId + 1),
    SizedBox(
      height: AppSize.s270,
      child: ListView.builder(
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
  ];
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
                                  radius: 14,
                                  backgroundColor: item.isSaved
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
            if (sectionId == 0)
              Padding(
                padding: const EdgeInsets.only(top: AppPadding.p10),
                child: Text(getPrice(item.price)),
              ),
            const SizedBox(
              height: 10,
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
