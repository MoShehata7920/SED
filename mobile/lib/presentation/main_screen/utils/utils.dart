import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

class Utils {
  static List<Category> categories = [];
  static Map<int, String> sections = {
    0: AppStrings.appSections[0],
    1: AppStrings.appSections[1],
    2: AppStrings.appSections[2],
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

  static bool isDialogShown = false;
}
