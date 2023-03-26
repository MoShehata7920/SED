import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sed/presentation/resources/icon_broken.dart';

class IconsManager {
  static const email = CupertinoIcons.mail;
  static const lock = IconBroken.lock;
  static const passwordVisible = CupertinoIcons.eye_fill;
  static const passwordNotVisible = CupertinoIcons.eye_slash_fill;
  static const phone = IconBroken.call;

  static const List<IconData> iconsList = [
    IconBroken.home,
    IconBroken.chat,
    IconBroken.heart,
    IconBroken.setting,
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
    FontAwesomeIcons.cubes,
    FontAwesomeIcons.basketball,
    FontAwesomeIcons.car,
  ];

  // add item screen
  static const addRounded = IconBroken.plus;

  static const close = CupertinoIcons.xmark;

  // settings screen
  static const rightRoundedArrow = IconBroken.arrowRightCircle;
  static const account = IconBroken.profile;
  static const myAds = IconBroken.folder;
  static const languageController = CupertinoIcons.globe;
  static const themeController = CupertinoIcons.color_filter;
  static const share = Icons.share_outlined;
  static const help = CupertinoIcons.info;
  static const questionMark = IconBroken.infoCircle;

  // my Ads screen
  static const update = IconBroken.edit;
  static const delete = IconBroken.delete;

  // search screen
  static const micOn = CupertinoIcons.mic;
  static const micOff = CupertinoIcons.mic_off;
}
