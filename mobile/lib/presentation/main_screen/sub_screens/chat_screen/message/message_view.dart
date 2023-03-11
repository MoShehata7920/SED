import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/color_manager.dart';

class MessagingScreenView extends StatefulWidget {
  const MessagingScreenView({super.key});

  @override
  State<MessagingScreenView> createState() => _MessagingScreenViewState();
}

class _MessagingScreenViewState extends State<MessagingScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70),
          child: AppBar(
            backgroundColor: ColorsManager.background,
            automaticallyImplyLeading: false,
            leading: Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 0.0, 0.0),
              child: InkWell(
                onTap: () async {
                },
              ),
            ),
          )),
    );
  }
}
