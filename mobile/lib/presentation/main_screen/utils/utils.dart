import 'package:easy_localization/easy_localization.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

class Utils {
  static List<Category> categories = [];
  static Map<int, String> sections = {
    0: AppStrings.sellProducts.tr(),
    1: AppStrings.exchange.tr(),
    2: AppStrings.donate.tr(),
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
