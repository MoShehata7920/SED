import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../resources/color_manager.dart';
import '../../../../resources/values_manager.dart';
import '../viewmodel/notifications_screen_viewmodel.dart';

class NotificationScreenView extends StatefulWidget {
  const NotificationScreenView({super.key});

  @override
  NotificationScreenViewState createState() => NotificationScreenViewState();
}

class NotificationScreenViewState extends State<NotificationScreenView> {
  final _viewModel = NotificationScreenViewModel();

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _viewModel.start();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorsManager.primaryBackground,
        title: Text(
          AppStrings.notifications,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.primaryText,
                fontWeight: FontWeight.bold,
                fontSize: AppSize.s18,
              ),
        ),
      ),
      body: StreamBuilder<Notifications>(
        stream: _viewModel.notificationsOutput,
        builder: (context, snapshot) {
          return _getContent(snapshot.data);
        },
      ),
    );
  }

  Widget _getContent(Notifications? notifications) {
    if (notifications == null) {
      return Container();
    } else {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: notifications.notifications.length,
        itemBuilder: (context, index) {
          notifications.notifications[index];
          return Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius:
                    const BorderRadius.all(Radius.circular(AppSize.s20)),
                color: ColorsManager.secondaryBackground,
              ),
              child: ListTile(
                title: Row(
                  children: [
                    if (!notifications.notifications[index].isSeen) _buildDot(),
                    Expanded(
                      child: Text(
                        notifications.notifications[index].title,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.primaryText,
                              fontSize: AppSize.s16,
                            ),
                      ),
                    ),
                  ],
                ),
                subtitle: Text(
                  notifications.notifications[index].description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.secondaryText,
                        fontSize: AppSize.s12,
                      ),
                ),
                trailing: Text(
                  Utils.getCreatedTime(
                      "TODO"),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.secondaryText,
                        fontSize: AppSize.s14,
                      ),
                ),
              ),
            ),
          );
        },
      );
    }
  }

  Widget _buildDot() {
    return Row(
      children: [
        Container(
          width: AppSize.s10,
          height: AppSize.s10,
          decoration: BoxDecoration(
            color: ColorsManager.error,
            borderRadius: BorderRadius.circular(AppPadding.p10),
          ),
        ),
        const SizedBox(width: AppSize.s8),
      ],
    );
  }
}
