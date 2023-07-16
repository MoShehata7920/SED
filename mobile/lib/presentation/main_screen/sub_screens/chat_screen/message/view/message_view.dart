// ignore_for_file: no_logic_in_create_state, no_leading_underscores_for_local_identifiers

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/message/viewmodel/message_viewmodel.dart';
import 'package:sed/presentation/main_screen/sub_screens/chat_screen/viewmodel/chat_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class MessagingScreenView extends StatefulWidget {
  const MessagingScreenView(
      this.image, this.name, this.sellerId, this.conversationId,
      {super.key});

  final String? image;
  final String? name;
  final String? sellerId;
  final String? conversationId;

  @override
  State<MessagingScreenView> createState() =>
      _MessagingScreenViewState(image, name, sellerId, conversationId);
}

class _MessagingScreenViewState extends State<MessagingScreenView> {
  String? image;
  String? name;
  String? sellerId;
  String? conversationId;
  GetChatMessages? messages;

  _MessagingScreenViewState(
      this.image, this.name, this.sellerId, this.conversationId);


  final MessageViewModel _messageViewModel = MessageViewModel();

  final TextEditingController _textEditingController = TextEditingController();

  final _scrollController = ScrollController();

  void _bind() async {
    if (conversationId != null) {
      messages =
          await _messageViewModel.getConversationMessages(conversationId!);
    } else {
      // Make new conversation
      conversationId =
          await _messageViewModel.createNewConversation(sellerId ?? "");
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {

    if(_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget result = Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppSize.s70),
        child: AppBar(
          backgroundColor: ColorsManager.primaryBackground,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: ColorsManager.primaryBackground,
                backgroundImage: NetworkImage(image ?? AppStrings.noProfilePic),
              ),
              const SizedBox(
                height: AppSize.s5,
              ),
              Text(
                name ?? AppStrings.empty,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primaryText,
                      fontSize: AppSize.s12,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: StreamBuilder<FlowState>(
        stream: _messageViewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data
                  ?.getScreenWidget(context, _getBody(), () => () {}) ??
              _getBody();
        },
      ),
    );

    return result;
  }

  Widget _getBody() {
    final ChatViewModel _chatViewModel = instance<ChatViewModel>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
      child: StreamBuilder<Messages>(
        stream: _chatViewModel.socketOutput,
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            messages!.messages.add(snapshot.data!);
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: messages != null
                        ? messages!.messages.map((message) {
                            if (message.senderId == Utils.getUserId()) {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: buildMyMessage(message.message),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: buildReceivedMessage(message.message),
                              );
                            }
                          }).toList()
                        : [],
                  ),
                ),
              ),
              const SizedBox(height: AppSize.s20),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: AppStrings.typeMessage.tr(),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: AppPadding.p20,
                            vertical: AppPadding.p10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s30),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSize.s30),
                          borderSide: BorderSide(
                            color: ColorsManager.tertiaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSize.s20),
                  IconButton(
                    onPressed: () {
                      _messageViewModel.sendMessage(
                        conversationId ?? "",
                        Utils.getUserId(),
                        _textEditingController.text,
                      );

                      _textEditingController.clear();
                    },
                    icon: Icon(
                      IconsManager.send,
                      color: ColorsManager.grayIcon,
                    ),
                  ),
                  IconButton(
                    onPressed: () async {
                      // ignore: unused_local_variable
                      final image = await Navigator.pushNamed(
                          context, Routes.cameraScreenRoute);
                    },
                    icon: Icon(
                      IconsManager.gallery,
                      color: ColorsManager.grayIcon,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s5),
            ],
          );
        },
      ),
    );
  }

  Widget buildReceivedMessage(String model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                ColorsManager.receivedMessage,
                ColorsManager.receivedMessage
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(AppSize.s10),
              topStart: Radius.circular(AppSize.s10),
              topEnd: Radius.circular(AppSize.s10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p5,
            horizontal: AppPadding.p10,
          ),
          child: Text(
            model,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.receivedMessageText,
                fontSize: AppSize.s12,
                fontWeight: FontWeight.w100),
          ),
        ),
      );

  Widget buildMyMessage(String model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [ColorsManager.myMessage, ColorsManager.myMessage],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(AppSize.s10),
              topStart: Radius.circular(AppSize.s10),
              topEnd: Radius.circular(AppSize.s10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p5,
            horizontal: AppPadding.p10,
          ),
          child: Text(
            model,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.myMessageText,
                fontSize: AppSize.s12,
                fontWeight: FontWeight.w100),
          ),
        ),
      );

  @override
  void dispose() {
    _scrollController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }
}
