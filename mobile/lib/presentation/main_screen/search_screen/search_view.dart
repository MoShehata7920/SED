import 'package:flutter/material.dart';
import 'package:sed/presentation/main_screen/search_screen/search_viewmodel.dart';

class SearchView extends StatefulWidget {
  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final SearchViewModel _viewModel = SearchViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();
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
            hintText: 'Search...',
            border: InputBorder.none,
          ),
        ),
      ),
      body: StreamBuilder<String>(
        stream: _viewModel.onSearchChanged,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final searchTerm = snapshot.data!;
            // TODO: use search term to fetch data and display it
          }
          return Center(
            child: Text('Enter a search term'),
          );
        },
      ),
    );
  }
}
