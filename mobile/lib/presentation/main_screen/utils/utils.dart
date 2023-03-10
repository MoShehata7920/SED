import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sed/domain/model/models.dart';

class Utils {
  static List<Category> categories = [];
  static Map<int, String> sections = {
    0 : "Sell Products",
    1 : "Exchange",
    2 : "Donate"
  };

  static String getCategoryNameById(int id) {
    String categoryName = "";

    for (var element in categories) {
      if (element.id == id) {
        categoryName = element.name;
        break;
      }
    }

    return categoryName;
  }
}
