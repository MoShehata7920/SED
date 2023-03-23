import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class IconsManager {
  static const email = CupertinoIcons.mail_solid;
  static const lock = CupertinoIcons.lock_fill;
  static const passwordVisible = CupertinoIcons.eye_fill;
  static const passwordNotVisible = CupertinoIcons.eye_slash_fill;
  static const useName = CupertinoIcons.profile_circled;
  static const phone = CupertinoIcons.phone_solid;

  static const List<IconData> iconsList = [
    CupertinoIcons.home,
    CupertinoIcons.conversation_bubble,
    CupertinoIcons.heart_fill,
    CupertinoIcons.settings_solid,
  ];

  static const rightArrow = CupertinoIcons.forward;

  static const search = CupertinoIcons.search;
  static const notification = CupertinoIcons.bell;

  static const add = CupertinoIcons.add;
  static const location = CupertinoIcons.location_solid;

  static const chat = CupertinoIcons.chat_bubble_2_fill;

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

  static const close = CupertinoIcons.xmark;

  // settings screen
  static const rightRoundedArrow = CupertinoIcons.arrow_right_circle;
  static const account = CupertinoIcons.group_solid;
  static const myAds = CupertinoIcons.collections_solid;
  static const languageController = CupertinoIcons.globe;
  static const themeController = CupertinoIcons.color_filter;
  static const share = CupertinoIcons.share_up;
  static const help = CupertinoIcons.info;
  static const questionMark = CupertinoIcons.question_circle_fill;

  // my Ads screen
  static const update = CupertinoIcons.pencil;
  static const delete = CupertinoIcons.trash;
}
