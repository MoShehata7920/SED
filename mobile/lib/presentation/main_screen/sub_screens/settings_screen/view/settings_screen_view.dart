import 'package:flutter/material.dart';
import 'package:sed/presentation/common/animation_manager/animation_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../resources/strings_manager.dart';

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
        elevation: 0,
        toolbarHeight: 135,
        title: Column(
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: AppSize.s14, left: AppSize.s5, right: AppSize.s18),
                  child: CircleAvatar(
                    radius: AppSize.s32,
                    backgroundImage: NetworkImage(
                        "https://cdn.24.co.za/files/Cms/General/d/2559/0862e2e9206a488d996a3a37afcde0de.jpg"),
                  ).animateOnPageLoad(
                      msDelay: 150, dx: 0.0, dy: -70.0, showDelay: 600),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                Column(
                  children: [
                    Text(
                      "Shehata & Hafez",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorsManager.primaryText,
                            fontSize: AppSize.s16,
                          ),
                    ).animateOnPageLoad(
                        msDelay: 150, dx: -70.0, dy: 0.0, showDelay: 600),
                    Text(
                      "Gharbya / Tanta",
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorsManager.secondaryText,
                            fontSize: AppSize.s10,
                          ),
                    ).animateOnPageLoad(
                        msDelay: 150, dx: 70.0, dy: 0.0, showDelay: 600),
                  ],
                ),
                Divider(
                  height: 15,
                  color: ColorManager.grey2,
                ).animateOnPageLoad(
                    msDelay: 150, dx: 0.0, dy: 0.0, showDelay: 600),
              ],
            )
          ],
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 15,
              ),
              _getInkwell(IconsManager.account, AppStrings.account, () {})
                  .animateOnPageLoad(
                      msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
              const SizedBox(
                height: AppSize.s5,
              ),
              _getInkwell(IconsManager.myAds, AppStrings.myAds, () {})
                  .animateOnPageLoad(
                      msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p25,
                    left: AppPadding.p8,
                    right: AppPadding.p5,
                    bottom: AppPadding.p5),
                child: Text(
                  textAlign: TextAlign.start,
                  AppStrings.settings,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorsManager.grey,
                      ),
                ),
              ).animateOnPageLoad(
                  msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
              _getInkwell(IconsManager.languageController, AppStrings.language,
                      () {})
                  .animateOnPageLoad(
                      msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
              const SizedBox(
                height: AppSize.s5,
              ),
              _getInkwell(IconsManager.themeController, AppStrings.theme, () {})
                  .animateOnPageLoad(
                      msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
              const SizedBox(
                height: AppSize.s5,
              ),
              _getInkwell(IconsManager.notification, AppStrings.notifications,
                      () {})
                  .animateOnPageLoad(
                      msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
              Padding(
                padding: const EdgeInsets.only(
                    top: AppPadding.p25,
                    left: AppPadding.p8,
                    right: AppPadding.p5,
                    bottom: AppPadding.p5),
                child: Text(
                  textAlign: TextAlign.start,
                  AppStrings.general,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: ColorsManager.grey,
                      ),
                ),
              ).animateOnPageLoad(
                  msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
              _getInkwell(IconsManager.share, AppStrings.share, () {
                Share.share(
                    'https://instagram.com/mohamed_shehata7920?igshid=ZDdkNTZiNTM=');
              }).animateOnPageLoad(
                  msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
              const SizedBox(
                height: AppSize.s5,
              ),
              _getInkwell(IconsManager.help, AppStrings.help, () {})
                  .animateOnPageLoad(
                      msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
              const SizedBox(
                height: AppSize.s5,
              ),
              _getInkwell(IconsManager.questionMark, AppStrings.aboutUs, () {})
                  .animateOnPageLoad(
                      msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            ],
          ),
        ],
      ),
    );
  }

  Widget _getInkwell(
      IconData inkwellIcon, String inkwellTitle, Function() inkwellFunction) {
    return InkWell(
      onTap: () {
        inkwellFunction();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(AppSize.s10)),
            color: ColorsManager.secondaryBackground,
          ),
          height: AppSize.s40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Icon(
                      inkwellIcon,
                      size: AppSize.s30,
                      color: ColorsManager.secondaryText,
                    ),
                  ),
                  Text(
                    inkwellTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsManager.secondaryText,
                          fontSize: AppSize.s14,
                        ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(AppPadding.p8),
                child: Icon(
                  IconsManager.rightRoundedArrow,
                  color: ColorsManager.secondaryText,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
