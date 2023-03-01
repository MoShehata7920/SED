import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
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
    return StreamBuilder<FlowState>(
      stream: _viewModel.outputState,
      builder: (context, snapshot) {
        return snapshot.data?.getScreenWidget(
                context, _getContentWidget(), () => _viewModel.getHomeData()) ??
            _getContentWidget();
      },
    );
  }

  Widget _getContentWidget() {
    return StreamBuilder<void>(
        stream: _viewModel.carouselOutput,
        builder: (context, snapshot) {
          return SingleChildScrollView(
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
                                image: NetworkImage(image ?? AppStrings.empty),
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
                            vertical: AppPadding.p8, horizontal: AppPadding.p4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? ColorManager.white
                                    : ColorManager.lightPrimary)
                                .withOpacity(
                                    _viewModel.carouselCurrentIndex == entry.key
                                        ? AppSize.s0_9
                                        : AppSize.s0_4)),
                      ),
                    );
                  }).toList(),
                ),
                _getIdentifyBar(AppStrings.categories),
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
                        _viewModel.categories.length >
                                AppValues.defaultCategoriesNumber
                            ? AppValues.defaultCategoriesNumber
                            : _viewModel.categories.length, (index) {
                      return Center(
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(AppPadding.p14),
                                  child: Image(
                                    image: NetworkImage(
                                        _viewModel.categories[index].image),
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: AppPadding.p8),
                                child: Text(
                                  _viewModel.categories[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                for (int i = 0; i < 3; i++) _getItems(0, _viewModel)[i],

                for (int i = 0; i < 3; i++) _getItems(1, _viewModel)[i],

                for (int i = 0; i < 3; i++) _getItems(2, _viewModel)[i],

                const SizedBox(
                  height: 100,
                )
                //preparing for the next widget maybe ?
              ],
            ),
          );
        });
  }
}

List<Widget> _getItems(int sectionId, HomeScreenViewModel viewModel) {
  return [
    const SizedBox(height: AppSize.s16),
    _getIdentifyBar(sectionId == 0
        ? AppStrings.sell
        : sectionId == 1
            ? AppStrings.donate
            : AppStrings.exchange),
    Container(
      height: 200,
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
            viewModel),
      ),
    ),
  ];
}

Widget _buildItem(
    Items item, int sectionId, HomeScreenViewModel homeScreenViewModel) {
  return Container(
    width: 200,
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
            child: Container(
              width: 150,
              height: 150,
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
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      getCategoryNameById(item.categoryId, homeScreenViewModel),
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
              item.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (sectionId == 0)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(getPrice(item.price)),
            )
          else
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: AppSize.s12, color: ColorManager.grey2),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '5 min ago',
                      textAlign: TextAlign.end,
                      maxLines: 1,
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
  );
}

Widget _getIdentifyBar(String category) => Container(
      height: AppSize.s40,
      color: ColorManager.fourthLightPrimary.withOpacity(0.5),
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
                onPressed: () {},
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

String getCategoryNameById(int id, HomeScreenViewModel homeScreenViewModel) {
  String categoryName = AppStrings.empty;

  homeScreenViewModel.categories.forEach((element) {
    if (element.id == id) categoryName = element.name;
  });
  return categoryName;
}
