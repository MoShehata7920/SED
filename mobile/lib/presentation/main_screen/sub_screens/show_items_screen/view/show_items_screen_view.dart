import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/domain/model/models.dart';
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
  int pageId = 0;
  double currentIntent = 0;
  bool isLoading = false;

  _ShowItemsViewState(this.viewType, this.categoryId);

  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  final ShowItemsViewModel _viewModel = ShowItemsViewModel();

  void _bind() {
    _viewModel.start();

    _viewModel.getItems(viewType, categoryId);

    _scrollController.addListener(() async {
      if (_scrollController.position.maxScrollExtent ==
          _scrollController.offset) {
        if (_viewModel.items.isNotEmpty && _viewModel.items.length % 20 == 0) {
          pageId++;

          currentIntent = _scrollController.offset;

          isLoading = true;

          await _viewModel.getMoreItems(viewType, categoryId, pageId);

          isLoading = false;
        }
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
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
    return StreamBuilder<ShowItemsContentObject>(
        stream: _viewModel.contentOutput,
        builder: (context, snapshot) {
          return _buildWidget(snapshot.data);
        });
  }

  Widget _buildWidget(ShowItemsContentObject? showItemsContentObject) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: AppSize.s50,
        title: Text(
          viewType.getName(categoryId: categoryId),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.lineColor,
                fontSize: AppSize.s30,
              ),
        ),
        backgroundColor: ColorsManager.primaryBackground,
      ),
      extendBody: true,
      backgroundColor: ColorsManager.primaryBackground,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapshot) {
            return snapshot.data?.getScreenWidget(
                    context,
                    _getContentWidget(showItemsContentObject),
                    () => _viewModel.getItems(viewType, categoryId)) ??
                _getContentWidget(showItemsContentObject);
          }),
    );
  }

  Widget _getContentWidget(ShowItemsContentObject? showItemsContentObject) {
    if (showItemsContentObject == null) {
      return Container();
    } else {
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
              children: List.generate(
                  showItemsContentObject.items.length,
                  (index) =>
                      _getItemWidget(index, viewType, showItemsContentObject)),
            ),
            if (isLoading)
              const CircularProgressIndicator()
            else
              const SizedBox(
                height: AppSize.s25,
              ),
          ]),
        ),
      );
    }
  }

  Widget _getItemWidget(int index, Views viewType,
      ShowItemsContentObject? showItemsContentObject) {
    final HomeScreenViewModel homeScreenViewModel =
        instance<HomeScreenViewModel>();
    if (showItemsContentObject == null) {
      return Container();
    } else {
      return InkWell(
        child: Card(
          elevation: 1,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s16)),
          color: ColorsManager.secondaryBackground,
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(
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

                            if (viewType == Views.SAVED) {
                              setState(() {});
                            }
                          },
                          icon: StreamBuilder<bool>(
                              stream: homeScreenViewModel.savedOutput,
                              builder: (context, snapshot) {
                                return CircleAvatar(
                                  radius: AppSize.s14,
                                  backgroundColor: showItemsContentObject
                                          .items[index].isSaved
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
                          Utils.getCategoryNameById(
                              showItemsContentObject.items[index].categoryId),
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
                                  fontSize: AppSize.s12,
                                  color: ColorsManager.grey2),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          showItemsContentObject.items[index].date,
                          textAlign: TextAlign.end,
                          maxLines: AppValues.maxDateLines,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: AppSize.s12,
                                  color: ColorsManager.grey2),
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

  Future _onRefresh() async {
    _viewModel.getItems(viewType, categoryId);
  }
}
