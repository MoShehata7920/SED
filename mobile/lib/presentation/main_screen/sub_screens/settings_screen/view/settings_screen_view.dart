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
    return Scaffold(
      backgroundColor: ColorManager.grey1.withOpacity(.2),
      appBar: AppBar(
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
        toolbarHeight: 135,
        title: Column(
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
                    const Text(
                      "Shehata & Hafez",
                      style: TextStyle(
                        fontSize: AppSize.s20,
                        fontWeight: FontWeight.bold,
                      ),
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
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.supervised_user_circle_outlined,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "Account",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.production_quantity_limits_outlined,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "MY ADS",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 5, bottom: 5),
            child: Text(
              textAlign: TextAlign.start,
              "Settings",
              style: TextStyle(color: ColorManager.grey),
            ),
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.language_outlined,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "Language",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.color_lens,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "Theme",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.notifications_active_outlined,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "Notification",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 5, bottom: 5),
            child: Text(
              textAlign: TextAlign.start,
              "General",
              style: TextStyle(color: ColorManager.grey),
            ),
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.share_outlined,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "Share",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.help,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "Help",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
          Container(
            color: ColorManager.white,
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.live_help_outlined,
                        size: 30,
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                    Text(
                      "About US",
                      style: TextStyle(
                        color: ColorManager.thirdLightPrimary,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_circle_right,
                    color: ColorManager.thirdLightPrimary,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
