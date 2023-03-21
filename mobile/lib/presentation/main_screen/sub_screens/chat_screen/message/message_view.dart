import 'dart:math';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class MessagingScreenView extends StatefulWidget {
  const MessagingScreenView({super.key});

  @override
  State<MessagingScreenView> createState() => _MessagingScreenViewState();
}

class _MessagingScreenViewState extends State<MessagingScreenView> {
  final ImagePicker _imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(AppSize.s70),
        child: AppBar(
          backgroundColor: ColorsManager.background,
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          title: Column(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(AppStrings.abdullahRagabImageUrl),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "mohamed shehata",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primaryText,
                      fontSize: 12.0,
                    ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: 70,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemBuilder: ((context, index) {
                  var random = Random();
                  bool me = random.nextBool();

                  if (me)
                    return buildReceivedMessage("hello world");
                  else
                    return buildMyMessage(
                        "hello world 2 asfas fas asf asf hello world 2 asfas fas asf asf hello world 2 asfas fas asf asf hello world 2 asfas fas asf asf hello world 2 asfas fas asf asf");
                }),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    // controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: "Type a message",
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    var image =
                        _imagePicker.pickImage(source: ImageSource.gallery);
                  },
                  icon: Icon(
                    Icons.image,
                    color: ColorsManager.primaryBtnText,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // TODO: Implement sending message
                    // _textEditingController.clear();
                  },
                  icon: Icon(
                    Icons.send,
                    color: ColorsManager.primaryBtnText,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }

  Widget buildReceivedMessage(String model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFD7D7D7), Color(0xFFF2F2F2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            model,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.black,
                fontSize: 12.0,
                fontWeight: FontWeight.w100),
          ),
        ),
      );

  Widget buildMyMessage(String model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF3196FC), Color(0xFF007AFF)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 10,
          ),
          child: Text(
            model,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w100),
          ),
        ),
      );
}
