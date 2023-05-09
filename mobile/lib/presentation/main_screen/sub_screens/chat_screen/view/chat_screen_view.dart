import 'package:flutter/material.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/viewmodel/chat_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';

class ChatScreenView extends StatefulWidget {
  const ChatScreenView({super.key});

  @override
  State<ChatScreenView> createState() => _ChatScreenViewState();
}

class _ChatScreenViewState extends State<ChatScreenView> {
  final ChatViewModel _chatViewModel = ChatViewModel();

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
    return _getContentWidget(AppStrings.messages);
  }

  Widget _getContentWidget(snapshot) {
    if (snapshot == null) {
      return Container();
    }

    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryBackground,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          snapshot,
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
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Routes.messagingScreenRoute);
                        },
                        child: _messageObject(
                            context,
                            "http://i.epvpimg.com/tRsTeab.png",
                            "Mohamed Shehata",
                            "1:05",
                            "Hey bo, i wanna to buy this phone",
                            true),
                      ),
                      InkWell(
                        child: _messageObject(
                            context,
                            "http://i.epvpimg.com/y6anfab.png",
                            "Mahmoud Hafez",
                            "10:55",
                            "Let's connect Monday and talk about exchanging phones deal!",
                            false),
                      ),
                      InkWell(
                        child: _messageObject(
                            context,
                            "http://i.epvpimg.com/EKVpeab.png",
                            "Abdallah",
                            "1:43",
                            "Let's connect Monday and talk about exchanging phones deal! or u don't have free time",
                            false),
                      ),
                      InkWell(
                        child: _messageObject(
                            context,
                            "http://i.epvpimg.com/ioIcfab.png",
                            "Mahmoud Elamrosy",
                            "1:05",
                            "Let's connect Monday and talk about exchanging phones deal!",
                            true),
                      ),
                      InkWell(
                        child: _messageObject(
                            context,
                            "http://i.epvpimg.com/vTCgeab.png",
                            "Firminio",
                            "1:05",
                            "Let's connect Monday and talk about exchanging phones deal!",
                            true),
                      ),
                      InkWell(
                        child: _messageObject(
                            context,
                            "http://i.epvpimg.com/hB5oeab.png",
                            "Ezzat",
                            "1:05",
                            "Let's connect Monday and talk about exchanging phones deal!",
                            false),
                      ),
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

  Widget _messageObject(
      BuildContext context,
      String _messageImage,
      String _messageSender,
      String _messageTime,
      String _messageTitle,
      bool _isUnread) {
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
              if (_isUnread == true)
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
                    _messageImage,
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
                                        _messageSender,
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
                                          _messageTime,
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
                                    _messageTitle,
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
