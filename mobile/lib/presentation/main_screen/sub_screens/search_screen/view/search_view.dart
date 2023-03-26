import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
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
      appBar: AppBar(
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
      body: StreamBuilder<String>(
        stream: _viewModel.onSearchChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final searchTerm = snapshot.data!;
            // TODO: use search term to fetch data and display it
          }
          return Center(
            child: Text(AppStrings.enterSearchTerm.tr()),
          );
        },
      ),
    );
  }
}
