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
          AppStrings.aboutUs,
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
              AppStrings.ourTeam,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.primaryText,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSize.s22,
                  ),
            ),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mohamedShehata,
              title: AppStrings.mobileDeveloper,
              imageUrl: AppStrings.mohamedShehataImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mahmoudHafez,
              title: AppStrings.mobileDeveloper,
              imageUrl: AppStrings.mahmoudHafezImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.abdullahRagab,
              title: AppStrings.backendDeveloper,
              imageUrl: AppStrings.abdullahRagabImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mahmoudElamrosy,
              title: AppStrings.backendDeveloper,
              imageUrl: AppStrings.mahmoudElamrosyImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: 70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.mohamedAdel,
              title: AppStrings.frontDeveloper,
              imageUrl: AppStrings.mohamedAdelImageUrl,
            ).animateOnPageLoad(
                msDelay: 300, dx: -70.0, dy: 0.0, showDelay: 900),
            const SizedBox(height: AppSize.s16),
            _buildTeamMember(
              name: AppStrings.abdElrahmanEzzat,
              title: AppStrings.frontDeveloper,
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
              AppStrings.drElshwimySupervisor,
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
