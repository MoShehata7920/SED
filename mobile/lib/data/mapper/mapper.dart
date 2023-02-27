import 'package:sed/app/constants.dart';
import 'package:sed/app/extensions.dart';
import 'package:sed/data/responses/responses.dart';
import 'package:sed/domain/model/models.dart';

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    // * since we did an extension why do we check again if it was null ?
    return Authentication(this?.token.orEmpty() ?? Constants.empty);
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support.orEmpty() ?? Constants.empty;
  }
}

extension HomeCarouselMapper on CarouselResponse? {
  Carousel toDomain() {
    return Carousel(this?.images ?? <String>[]);
  }
}

extension HomeCategoriesMapper on List<CategoriesResponse?> {
  List<Category> toDomain() {
    List<Category> temporary = [];

    forEach((element) {
      //todo if not found put default image not found
      temporary.add(Category(element?.name ?? "", element?.image ?? ""));
    });

    return temporary;
  }
}

extension HomeResponseMapper on HomeResponse? {
  Home toDomain() {
    return Home(this?.carousel.toDomain(), this?.categories.toDomain());
  }
}

