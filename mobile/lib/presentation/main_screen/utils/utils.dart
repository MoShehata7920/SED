import 'package:sed/domain/model/models.dart';

class Utils {
  static List<Category> categories = [];

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
