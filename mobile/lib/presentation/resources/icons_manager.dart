import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import 'custom_icons_icons.dart';

class IconsManager {
  static const email = CupertinoIcons.mail;
  static const lock = IconBroken.lock;
  static const passwordVisible = CupertinoIcons.eye_fill;
  static const passwordNotVisible = CupertinoIcons.eye_slash_fill;
  static const phone = IconBroken.call;

  static List<TabItem> iconsList = [
    TabItem(icon: Icons.home, title: AppStrings.home),
    TabItem(icon: IconBroken.chat, title: AppStrings.chat),
    TabItem(icon: Icons.add, title: AppStrings.add),
    TabItem(icon: IconBroken.heart, title: AppStrings.saved),
    TabItem(icon: IconBroken.setting, title: AppStrings.settings),
  ];
  static const barsStaggered = FontAwesomeIcons.barsStaggered;
  static const filter = IconBroken.filter2;
  static const saved = IconBroken.heart;
  static const category = IconBroken.category;

  static const rightArrow = IconBroken.arrowRight;

  static const search = IconBroken.search;
  static const notification = IconBroken.notification;

  static const add = CupertinoIcons.add;
  static const location = IconBroken.location;

  static const chat = IconBroken.chat;

  static const google = FontAwesomeIcons.google;

  static List<IconData> categoriesIcons = [
    FontAwesomeIcons.laptop,
    FontAwesomeIcons.shirt,
    FontAwesomeIcons.mobile,
    FontAwesomeIcons.bookOpen,
    FontAwesomeIcons.chair,
    FontAwesomeIcons.burger,
    FontAwesomeIcons.soap,
    FontAwesomeIcons.basketball,
    FontAwesomeIcons.car,
    FontAwesomeIcons.cubes,
  ];

  // add item screen
  static const addRounded = IconBroken.plus;

  static const close = CupertinoIcons.xmark;

  // settings screen
  static const rightRoundedArrow = IconBroken.arrowRightCircle;
  static const account = IconBroken.profile;
  static const myAds = IconBroken.folder;
  static const languageController = CustomIcons.language_toggle;
  static const themeController = CustomIcons.theme;
  static const share = CustomIcons.share;
  static const help = CustomIcons.customer_support;
  static const questionMark = CustomIcons.info;
  static const password = IconBroken.password;

  // my Ads screen
  static const update = IconBroken.edit;
  static const delete = IconBroken.delete;

  // search screen
  static const micOn = CupertinoIcons.mic;
  static const micOff = CupertinoIcons.mic_off;

  // camera screen
  static const camera = IconBroken.camera;
  static const gallery = Icons.photo_library_outlined;
  static const done = Icons.done;

  static const calender = IconBroken.calendar;

  // chat
  static const send = IconBroken.send;
}
