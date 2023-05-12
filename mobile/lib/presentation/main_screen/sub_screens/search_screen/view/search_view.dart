import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../../domain/model/models.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/routes_manager.dart';
import '../../../../resources/values_manager.dart';
import '../viewmodel/search_viewmodel.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  SearchViewState createState() => SearchViewState();
}

class SearchViewState extends State<SearchView> {
  final SearchViewModel _viewModel = SearchViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _viewModel.initSpeechRecognition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        title: TextField(
          controller: _viewModel.searchController,
          autofocus: true,
          onChanged: _viewModel.onSearchTextChanged,
          decoration: InputDecoration(
            hintText: AppStrings.searchHere.tr(),
            border: InputBorder.none,
          ),
        ),
        actions: [
          StreamBuilder<bool>(
              stream: _viewModel.micOutput,
              builder: (context, snapshot) {
                return IconButton(
                  icon: Icon((snapshot.data ?? true)
                      ? IconsManager.micOn
                      : IconsManager.micOff),
                  onPressed: () {
                    (_viewModel.speech.isNotListening)
                        ? _viewModel.startListening()
                        : _viewModel.stopListening();
                  },
                );
              }),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: StreamBuilder<String>(
          stream: _viewModel.onSearchChanged,
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              if (_viewModel.items == null) {
                return const Center(child: CircularProgressIndicator());
              }

              List<Widget> temp = [];

              for (var element in _viewModel.items!.items) {
                temp.add(_getProduct(element));
              }

              return Column(children: temp);
            } else {
              return Center(
                  child: Text(
                AppStrings.searchHere.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: ColorsManager.primaryText),
              ));
            }
          },
        ),
      ),
    );
  }

  Widget _getProduct(Items item) {
    return InkWell(
      child: Center(
        child: Column(
          children: [
            const SizedBox(height: AppSize.s10),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                color: ColorsManager.secondaryBackground,
                borderRadius: BorderRadius.circular(AppSize.s8),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsetsDirectional.all(AppPadding.p10),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            alignment: Alignment.topLeft,
                            children: [
                              Container(
                                width: AppSize.s100,
                                height: AppSize.s100,
                                decoration: BoxDecoration(
                                    color: ColorsManager.secondaryBackground,
                                    borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(AppSize.s8),
                                        bottomLeft: Radius.circular(AppSize.s8)),
                                    image: DecorationImage(
                                      image: NetworkImage(item.image),
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.4),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(AppSize.s8)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: AppSize.s5,
                                      vertical: AppSize.s2),
                                  child: Text(
                                    AppStrings.sell.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                            fontSize: AppSize.s12,
                                            color: ColorsManager.primaryText),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsetsDirectional.all(AppPadding.p10),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    item.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: ColorsManager.primaryText,
                                          fontSize: AppSize.s18,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(AppPadding.p8),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    child: Text(
                                      item.price.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color: ColorsManager.secondaryText,
                                            fontSize: AppSize.s14,
                                          ),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.3,
                                  child: Text(
                                    item.description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: ColorsManager.grey,
                                          fontSize: AppSize.s12,
                                        ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: AppSize.s10,
            ),
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, Routes.itemScreenRoute,
            arguments: item.id);
      },
    );
  }
}
