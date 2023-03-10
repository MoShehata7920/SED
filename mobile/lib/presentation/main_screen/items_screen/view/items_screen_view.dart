import 'package:flutter/material.dart';
import 'package:sed/app/functions.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/items_screen/viewmodel/items_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ItemView extends StatefulWidget {
  Object? itemId;

  ItemView(this.itemId, {Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api, no_logic_in_create_state
  _ItemViewState createState() => _ItemViewState(itemId as int);
}

class _ItemViewState extends State<ItemView> {
  final ItemsScreenViewModel _viewModel = ItemsScreenViewModel();

  int itemId;

  _ItemViewState(this.itemId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () => _viewModel.getItemData(itemId)) ??
              _getContentWidget();
        },
      ),
    );
  }

  void _bind() {
    _viewModel.start();

    _viewModel.getItemData(itemId);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });
  }

  Widget _getContentWidget() {
    return CustomScrollView(slivers: [
      SliverAppBar(
        expandedHeight: MediaQuery.of(context).size.height * 0.6,
        elevation: AppSize.s0,
        snap: true,
        floating: true,
        stretch: true,
        backgroundColor: ColorsManager.primaryBackground,
        flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
            ],
            background: Image.network(
              _viewModel.item.item.image,
              fit: BoxFit.cover,
            )),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(AppSize.s45),
            child: Transform.translate(
              offset: const Offset(AppSize.s0, AppSize.s1),
              child: Container(
                height: AppSize.s45,
                decoration: BoxDecoration(
                  color: ColorsManager.primaryBackground,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s30),
                    topRight: Radius.circular(AppSize.s30),
                  ),
                ),
                child: Center(
                    child: Container(
                  width: AppSize.s50,
                  height: AppSize.s8,
                  decoration: BoxDecoration(
                    color: ColorsManager.secondaryText,
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                )),
              ),
            )),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            height: MediaQuery.of(context).size.height,
            color: ColorsManager.primaryBackground,
            padding: const EdgeInsets.symmetric(
                horizontal: AppSize.s20, vertical: AppSize.s5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _viewModel.item.item.name,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: ColorsManager.white,
                                    fontSize: AppSize.s20,
                                  ),
                        ),
                        const SizedBox(
                          height: AppSize.s5,
                        ),
                        Container(
                          color: Colors.black.withOpacity(.2),
                          child: Text(
                            Utils.getCategoryNameById(
                                _viewModel.item.item.categoryId),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorsManager.primaryBtnText,
                                      fontSize: AppSize.s14,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      getPrice(_viewModel.item.item.price),
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorsManager.white,
                            fontSize: AppSize.s16,
                          ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  _viewModel.item.item.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.secondaryText,
                        fontSize: AppSize.s14,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      IconsManager.location,
                      size: AppSize.s12,
                      color: ColorManager.grey2,
                    ),
                    Expanded(
                      child: Text(
                        _viewModel.item.userData.address,
                        textAlign: TextAlign.start,
                        maxLines: AppValues.maxAddressLines,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.primaryBtnText,
                              fontSize: AppSize.s14,
                            ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        _viewModel.item.item.date,
                        textAlign: TextAlign.end,
                        maxLines: AppValues.maxDateLines,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.primaryBtnText,
                              fontSize: AppSize.s14,
                            ),
                      ),
                    ),
                  ],
                ),
                const Divider(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.user,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.primaryBtnText,
                        fontSize: AppSize.s18,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: AppSize.s28,
                      backgroundImage:
                          NetworkImage(_viewModel.item.userData.image),
                    ),
                    const SizedBox(
                      width: AppSize.s14,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _viewModel.item.userData.name,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorsManager.white,
                                    ),
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () => launchUrl(Uri(
                                      scheme: "tel",
                                      path: _viewModel.item.userData.phone)),
                                  child: Text(_viewModel.item.userData.phone)),
                              TextButton(
                                child: Text(
                                  AppStrings.showProfile,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: ColorsManager.primaryColor,
                                      ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, Routes.showProfileScreenRoute,
                                      arguments: _viewModel.item.userData);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                Center(
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      textStyle: TextStyle(color: ColorsManager.primaryColor),
                      backgroundColor: ColorsManager.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppSize.s24),
                      ),
                    ),
                    onPressed: () => {},
                    icon: Icon(
                      IconsManager.chat,
                      color: ColorsManager.primaryBackground,
                    ),
                    label: Text(AppStrings.chat,
                        style: TextStyle(
                          color: ColorsManager.primaryBackground,
                        )),
                  ),
                ),
                const Divider(
                  height: AppSize.s14,
                )
              ],
            ))
      ])),
    ]);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
