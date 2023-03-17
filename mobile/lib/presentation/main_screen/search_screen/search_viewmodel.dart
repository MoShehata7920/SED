import 'dart:async';

import 'package:flutter/material.dart';

class SearchViewModel {
  final TextEditingController searchController = TextEditingController();
  final StreamController<String> _searchStreamController =
  StreamController<String>.broadcast();

  Stream<String> get onSearchChanged => _searchStreamController.stream;

  void onSearchTextChanged(String value) {
    _searchStreamController.add(value);
  }

  void dispose() {
    searchController.dispose();
    _searchStreamController.close();
  }
}
