import 'package:flutter/material.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({super.key});

  @override
  State<SettingsScreenView> createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('settings'));
  }
}
