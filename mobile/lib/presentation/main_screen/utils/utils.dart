import 'package:easy_localization/easy_localization.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sprintf/sprintf.dart';

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

  static String getCreatedTime(DateTime dt) {
    var now =  DateTime.now().toUtc();
    var dtUtc = DateTime.utc(dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second);

    var timeSpan =now.difference(dtUtc);

    if (timeSpan.inSeconds <= 60) {
      return sprintf("%d seconds ago", [timeSpan.inSeconds]);
    }

    if (timeSpan.inMinutes <= 60) {
      return sprintf("%d minutes ago", [timeSpan.inMinutes]);
    }

    if (timeSpan.inHours <= 24) {
      return sprintf("%d hours ago", [timeSpan.inHours]);
    }

    if (timeSpan.inDays <= 30) {
      return sprintf("%d days ago", [timeSpan.inDays]);
    }

    if (timeSpan.inDays <= 365) {
      return sprintf("%d months ago", [(timeSpan.inDays / 30).round()]);
    }

    return sprintf("%d years ago", [(timeSpan.inDays / 365).round()]);
  }
}
