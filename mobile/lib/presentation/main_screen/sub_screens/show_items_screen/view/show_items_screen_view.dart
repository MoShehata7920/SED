import 'package:flutter/material.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/viewmodel/show_items_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

// ignore: must_be_immutable
class ShowItemsView extends StatefulWidget {
  ShowItemsView(this.type, {super.key});
  Object? type;

  @override
  // ignore: no_logic_in_create_state
  State<ShowItemsView> createState() => _ShowItemsViewState(type as Views);
}

class _ShowItemsViewState extends State<ShowItemsView> {
  Views viewType;

  _ShowItemsViewState(this.viewType);

  final ScrollController _scrollController = ScrollController(
    initialScrollOffset: 0.0,
    keepScrollOffset: true,
  );

  final ShowItemsViewModel _viewModel = ShowItemsViewModel();

  void _bind() {
    _viewModel.start();

    _viewModel.getItems(viewType);
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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: AppSize.s50,
        title: Text(
          viewType.getName(),
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
                    () => _viewModel.getItems(viewType)) ??
                _getContentWidget();
          }),
    );
  }

  Widget _getContentWidget() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(children: [
        const SizedBox(
          height: AppSize.s10,
        ),
        const SizedBox(
          height: AppSize.s20,
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: AppValues.showItemCrossAxisCounts,
          physics: const ScrollPhysics(),
          children: List.generate(_viewModel.items.length,
              (index) => _getItemWidget(index, viewType, context)),
        )
      ]),
    );
  }

  Widget _getItemWidget(int index, Views viewType, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: AppPadding.p4, left: AppPadding.p2, right: AppPadding.p2),
      child: Center(child: viewType.getCard(_viewModel.items[index], context)),
    );
  }
}
