import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/viewmodel/chat_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../resources/values_manager.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final ChatViewModel _chatViewModel =
  instance<ChatViewModel>();

  void _bind() {
    _chatViewModel.getAllConversations();
  }

  @override
  void initState() {
    _chatViewModel.start();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });

    super.initState();
  }

  @override
  void dispose() {
    _chatViewModel.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      body: StreamBuilder<FlowState>(
        stream: _chatViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context, _getContentWidget(), () => () {}) ??
              _getContentWidget();
        },
      ),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryBackground,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          AppStrings.messages,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: AppSize.s16, color: ColorsManager.primaryText),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  AppPadding.p0, AppPadding.p0, AppPadding.p0, AppPadding.p12),
              child: Wrap(
                spacing: 0.0,
                runSpacing: 0.0,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.start,
                direction: Axis.horizontal,
                runAlignment: WrapAlignment.start,
                verticalDirection: VerticalDirection.down,
                clipBehavior: Clip.none,
                children: [
                  ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: AppSize.s5,
                      ),
                      Column(
                        children: _buildConversation(),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _buildConversation() {
    List<Widget> widgets = [];

    for (var element in _chatViewModel.conversations.conversationsData) {
      widgets.add(InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routes.messagingScreenRoute, arguments: [
            element.usersData[0].id == Utils.getUserId()
                ? element.usersData[1].image
                : element.usersData[0].image,
            element.usersData[0].id == Utils.getUserId()
                ? element.usersData[1].name
                : element.usersData[0].name,
            element.usersData[0].id == Utils.getUserId()
                ? element.usersData[1].id
                : element.usersData[0].id,
            element.id
          ]);
        },
        child: _messageObject(
            context,
            element.usersData[0].id == Utils.getUserId()
                ? element.usersData[1].image
                : element.usersData[0].image,
            element.usersData[0].id == Utils.getUserId()
                ? element.usersData[1].name
                : element.usersData[0].name,
            "1:05",
            "Hey bo, i wanna to buy this phone",
            true),
      ));
    }

    return widgets;
  }

  Widget _messageObject(
      BuildContext context,
      String messageImage,
      String messageSender,
      String messageTime,
      String messageTitle,
      bool isUnread) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
          AppPadding.p0, AppPadding.p6, AppPadding.p0, AppPadding.p0),
      child: SizedBox(
        width: double.infinity,
        height: AppSize.s65,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
              AppPadding.p12, AppPadding.p0, AppPadding.p0, AppPadding.p0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isUnread == true)
                Container(
                  width: AppSize.s10,
                  height: AppSize.s10,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor,
                    shape: BoxShape.circle,
                  ),
                )
              else
                Container(
                  width: AppSize.s10,
                  height: AppSize.s10,
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryBackground,
                    shape: BoxShape.circle,
                  ),
                ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p10,
                    AppPadding.p0, AppPadding.p12, AppPadding.p0),
                child: Container(
                  width: AppSize.s45,
                  height: AppSize.s45,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.network(
                    messageImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                AppPadding.p0,
                                AppPadding.p0,
                                AppPadding.p12,
                                AppPadding.p0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        messageSender,
                                        maxLines: 1,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge
                                            ?.copyWith(
                                                fontSize: AppSize.s16,
                                                fontWeight: FontWeight.w500,
                                                height: AppSize.s1_2,
                                                color:
                                                    ColorsManager.primaryText),
                                      ),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text(
                                          messageTime,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyLarge
                                              ?.copyWith(
                                                color:
                                                    ColorsManager.secondaryText,
                                                fontSize: AppSize.s14,
                                              ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                              AppPadding.p6,
                                              AppPadding.p0,
                                              AppPadding.p0,
                                              AppPadding.p0),
                                          child: Icon(
                                            Icons.chevron_right_rounded,
                                            color: ColorsManager.primaryColor,
                                            size: AppSize.s20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      AppPadding.p0,
                                      AppPadding.p0,
                                      AppPadding.p22,
                                      AppPadding.p0),
                                  child: Text(
                                    messageTitle,
                                    maxLines: 2,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                          color: ColorsManager.secondaryText,
                                          fontSize: AppSize.s14,
                                          fontWeight: FontWeight.normal,
                                          height: AppSize.s1_2,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
