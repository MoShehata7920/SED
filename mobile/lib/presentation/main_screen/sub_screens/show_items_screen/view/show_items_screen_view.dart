import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/home_screen/viewmodel/home_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/viewmodel/show_items_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

// ignore: must_be_immutable
class ShowItemsView extends StatefulWidget {
  ShowItemsView(this.type, {this.categoryId = 0, super.key});

  Views type;
  int categoryId;

  @override
  // ignore: no_logic_in_create_state
  State<ShowItemsView> createState() => _ShowItemsViewState(type, categoryId);
}

class _ShowItemsViewState extends State<ShowItemsView> {
  Views viewType;
  int categoryId;

  _ShowItemsViewState(this.viewType, this.categoryId);

  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  final ShowItemsViewModel _viewModel = ShowItemsViewModel();

  void _bind() {
    _viewModel.start();

    _viewModel.getItems(viewType, categoryId);
  }

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        print('LOAD HERE');
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () {
      _bind();
    });
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSize.s50,
        title: Text(
          viewType.getName(categoryId: categoryId),
          style: const TextStyle(
              fontSize: AppSize.s30, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration:
              BoxDecoration(gradient: ColorManager.secondLightPrimaryMix),
        ),
      ),
      extendBody: true,
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                    () => _viewModel.getItems(viewType, categoryId)) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(children: [
          const SizedBox(
            height: AppSize.s30,
          ),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: AppValues.showItemCrossAxisCounts,
            physics: const NeverScrollableScrollPhysics(),
            children: List.generate(_viewModel.items.length,
                (index) => _getItemWidget(index, viewType, context)),
          )
        ]),
      ),
    );
  }

  Widget _getItemWidget(int index, Views viewType, BuildContext context) {
    final HomeScreenViewModel homeScreenViewModel =
        instance<HomeScreenViewModel>();

    return Container(
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
                      _viewModel.items[index].image,
                      fit: BoxFit.fill,
                      width: double.infinity,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                          onPressed: () {
                            homeScreenViewModel
                                .toggleSavingProduct(_viewModel.items[index]);

                            if (viewType == Views.SAVED) {
                              setState(() {});
                            }
                          },
                          icon: StreamBuilder<bool>(
                              stream: homeScreenViewModel.savedOutput,
                              builder: (context, snapshot) {
                                return CircleAvatar(
                                  radius: 14,
                                  backgroundColor:
                                      _viewModel.items[index].isSaved
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
                            _viewModel.items[index].categoryId),
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
                _viewModel.items[index].name,
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
                        _viewModel.items[index].date,
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
            arguments: _viewModel.items[index].id);
      },
    ));
  }

  Future _onRefresh() async {
    _viewModel.getItems(viewType, categoryId);
  }
}
