import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/custom_icons_icons.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

import '../../../../../resources/color_manager.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.help.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.secondaryText,
                fontSize: AppSize.s22,
              ),
        ),
        elevation: 0,
        backgroundColor: ColorsManager.primaryBackground,
        iconTheme: IconThemeData(color: ColorsManager.primaryBtnText),
      ),
      body: Container(
        color: ColorsManager.primaryBackground,
        padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20, vertical: AppPadding.p10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.needHelp.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.s28,
                  ),
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.ifYouNeedHelp.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.secondaryText,
                    fontSize: AppSize.s18,
                  ),
            ),
            const SizedBox(height: AppSize.s20),
            ListTile(
              leading:
                  Icon(IconsManager.email, color: ColorsManager.primaryText),
              title: Text(
                AppStrings.email.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primaryText,
                      fontSize: AppSize.s18,
                    ),
              ),
              subtitle: Text(
                'support@example.com',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.secondaryText,
                    ),
              ),
              onTap: () {
                // Handle email tap
              },
            ),
            ListTile(
              leading:
                  Icon(IconsManager.phone, color: ColorsManager.primaryText),
              title: Text(
                AppStrings.phone.tr(),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primaryText,
                      fontSize: AppSize.s18,
                    ),
              ),
              subtitle: Text(
                '+1 (555) 123-4567',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.secondaryText,
                    ),
              ),
              onTap: () {
                // Handle phone tap
              },
            ),
            const SizedBox(height: AppSize.s20),
            Text(
              AppStrings.appreciateFeedBack.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.secondaryText,
                    fontSize: AppSize.s16,
                  ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    AppStrings.byEaglesTeam.tr(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: ColorsManager.secondaryText,
                          fontSize: AppSize.s14,
                        ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Icon(
                    CustomIcons.eagle__2_,
                    color: ColorsManager.secondaryText,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
