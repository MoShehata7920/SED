import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        toolbarHeight: 50,
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
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    ColorManager.secondLightPrimary,
                    ColorManager.thirdLightPrimary
                  ])),
        ),
      ),
      backgroundColor: ColorManager.white,
      body: _getContentWidget(),
           //destination screen
    );
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

  Widget _getContentWidget() {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            viewType.getName(),
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          physics: const ScrollPhysics(),
          children:
              List.generate(12, (index) => _getItemWidget(index, viewType)),
        )
      ]),
    );
  }

  Widget _getItemWidget(int index, Views viewType) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p4, left: 2, right: 2),
      child: Center(
          child: viewType.getCard()),
    );
  }
}
