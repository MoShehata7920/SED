import 'package:flutter/material.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/viewmodel/show_items_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
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
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(children: [
        const SizedBox(
          height: AppSize.s30,
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
    return Container(child: viewType.getCard(_viewModel.items[index], context));
  }
}
