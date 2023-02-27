import 'package:flutter/material.dart';

class FavoriteScreenView extends StatefulWidget {
  const FavoriteScreenView({super.key});

  @override
  State<FavoriteScreenView> createState() => _FavoriteScreenViewState();
}

class _FavoriteScreenViewState extends State<FavoriteScreenView> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('favorite'));
  }
}
