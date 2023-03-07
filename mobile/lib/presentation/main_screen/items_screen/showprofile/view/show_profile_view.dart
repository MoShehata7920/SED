import 'package:flutter/material.dart';
import 'package:sed/presentation/main_screen/items_screen/showprofile/viewmodel/show_profile_viewmodel.dart';

import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';

class ShowProfileView extends StatefulWidget {
  const ShowProfileView({super.key});

  @override
  State<ShowProfileView> createState() => _ShowProfileViewState();
}

class _ShowProfileViewState extends State<ShowProfileView> {

final ShowProfileViewModel _viewModel = ShowProfileViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGrey,
      appBar: AppBar(
        elevation: 0,
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
        toolbarHeight: 50,
        actions: [Icon(Icons.report)],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(children: [
          SizedBox(height: 5),
          Container(
            color: ColorManager.white,
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: AppSize.s32,
                      backgroundImage: NetworkImage(
                          "https://th.bing.com/th/id/R.d2ca3a69b073eff0942f365cf3791529?rik=YjESJzhFwqK1jg&pid=ImgRaw&r=0"),
                    ),
                    const SizedBox(
                      width: AppSize.s14,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shehata & Hafez",
                            style: TextStyle(
                                fontSize: 20,
                                color: ColorManager.thirdLightPrimary),
                          ),
                          const SizedBox(
                            height: AppSize.s5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "+20 01121145564",
                                style: TextStyle(
                                    fontSize: 13, color: ColorManager.grey2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ]),
          ),
          SizedBox(
            height: 3,
          ),
          Container(
            width: double.infinity,
            color: ColorManager.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Published Items (3)",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.secondLightPrimary),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
