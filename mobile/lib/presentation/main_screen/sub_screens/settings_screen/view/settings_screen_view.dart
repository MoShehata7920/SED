import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class SettingsScreenView extends StatefulWidget {
  const SettingsScreenView({super.key});

  @override
  State<SettingsScreenView> createState() => _SettingsScreenViewState();
}

class _SettingsScreenViewState extends State<SettingsScreenView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(
                  top: AppSize.s14, left: AppSize.s5, right: AppSize.s18),
              child: CircleAvatar(
                radius: AppSize.s32,
                backgroundImage: NetworkImage(
                    "https://cdn.24.co.za/files/Cms/General/d/2559/0862e2e9206a488d996a3a37afcde0de.jpg"),
              ),
            ),
            const SizedBox(
              height: AppSize.s12,
            ),
            Column(
              children: [
                Text(
                  "Shehata Hafez",
                  style: TextStyle(
                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.bold,
                      backgroundColor:
                          ColorManager.lightPrimary.withOpacity(.2)),
                ),
                Text(
                  "Gharbya / Tanta",
                  style: TextStyle(
                      fontSize: AppSize.s12, color: ColorManager.grey2),
                ),
              ],
            ),
            Divider(
              height: 15,
              color: ColorManager.grey2,
            )
          ],
        )
      ],
    );
  }
}
