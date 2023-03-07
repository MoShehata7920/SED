import 'package:flutter/material.dart';
import 'package:sed/presentation/main_screen/sub_screens/show_items_screen/view_handler.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class CategoriesScreenView extends StatefulWidget {
  const CategoriesScreenView({super.key});

  @override
  State<CategoriesScreenView> createState() => _CategoriesScreenViewState();
}

class _CategoriesScreenViewState extends State<CategoriesScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        toolbarHeight: AppSize.s50,
        title: const Text(
          "Categories",
          style: TextStyle(
              fontSize: AppSize.s30, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration:
          BoxDecoration(gradient: ColorManager.secondLightPrimaryMix),
        ),
      ),
      extendBody: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1/0.9,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(Utils.categories.length, (index) => _getItemWidget(index))),
          ],
        ),
      ),
    );
  }

  Widget _getItemWidget(index) {
    return InkWell(
      child: Card(
        elevation: 1,
        child: Column(children: [
          Flexible(
            flex: 2,
            child: Image(
              height: 100,
              image: NetworkImage(
                  Utils.categories[index].image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.lightBlue.withOpacity(0.1),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          Utils.categories[index].name,
                          style: TextStyle(
                            color: ColorManager.thirdLightPrimary,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Expanded(
                        child: Text(
                          '+5000 ads',
                          style: TextStyle(
                            fontSize: 10,
                            color: ColorManager.grey2,
                          ),
                        ),
                      ),
                    ]),
              ),
            ),
          )
        ]),
      ),
      onTap: () {
        Navigator.pushNamed(
            context, Routes.showItemsScreenRoute,
            arguments: [
              Views.CATEGORY,
              Utils.categories[index].id
            ]);
      },
    );
  }
}
