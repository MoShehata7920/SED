import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/common/animation_manager/animation_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import '../../../../../resources/color_manager.dart';
import '../../../../../resources/values_manager.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.primaryBackground,
        title: Text(
          AppStrings.aboutUs.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.secondaryText,
                fontWeight: FontWeight.bold,
                fontSize: AppSize.s18,
              ),
        ),
        iconTheme: IconThemeData(color: ColorsManager.primaryBtnText),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.ourTeam.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.s22,
                  ),
            ),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mohamedShehata.tr(),
              title: AppStrings.mobileDeveloper.tr(),
              imageUrl: AppStrings.mohamedShehataImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mahmoudHafez.tr(),
              title: AppStrings.mobileDeveloper.tr(),
              imageUrl: AppStrings.mahmoudHafezImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.abdullahRagab.tr(),
              title: AppStrings.backendDeveloper.tr(),
              imageUrl: AppStrings.abdullahRagabImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mahmoudElamrosy.tr(),
              title: AppStrings.backendDeveloper.tr(),
              imageUrl: AppStrings.mahmoudElamrosyImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mohamedAdel.tr(),
              title: AppStrings.frontDeveloper.tr(),
              imageUrl: AppStrings.mohamedAdelImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.abdElrahmanEzzat.tr(),
              title: AppStrings.frontDeveloper.tr(),
              imageUrl: AppStrings.abdElrahmanEzzatImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s32),
            Text(
              AppStrings.eaglesTeam,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.s22,
                  ),
            ),
            const SizedBox(height: AppSize.s8),
            Text(
              AppStrings.drElshwimySupervisor.tr(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.secondaryText,
                    fontSize: AppSize.s14,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(
      {String name = "", String title = "", String imageUrl = ""}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: AppSize.s24,
          backgroundImage: NetworkImage(imageUrl),
        ),
        const SizedBox(width: AppSize.s16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                color: ColorsManager.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: AppSize.s18,
              ),
            ),
            const SizedBox(height: AppSize.s4),
            Text(
              title,
              style: TextStyle(
                color: ColorsManager.secondaryText,
                fontSize: AppSize.s16,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
