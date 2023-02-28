import 'package:carousel_slider/carousel_slider.dart';
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

extension HomeCategoriesMapper on List<CategoriesResponse?>? {
  List<Category> toDomain() {
    List<Category> temporary = [];

    this?.forEach((element) {
      //todo if not found put default image not found
      temporary.add(Category(
          element?.id ?? 0, element?.name ?? "", element?.image ?? ""));
    });

    return temporary;
  }
}

extension ItemsMapper on List<ItemsResponse?>? {
  List<Items> toDomain() {
    List<Items> temporary = [];

    this?.forEach((element) {
      temporary.add(Items(
          element?.name ?? "",
          element?.image ?? "",
          element?.price ?? 0,
          element?.description ?? "",
          element?.categoryId ?? 0));
    });

    return temporary;
  }
}

extension HomeResponseMapper on HomeResponse? {
  Home toDomain() {
    return Home(
      this?.carousel?.toDomain() as Carousel,
      this?.categories?.toDomain() as List<Category>,
      this?.sellItems?.toDomain() as List<Items>,
      this?.donateItems?.toDomain() as List<Items>,
      this?.exchangeItems?.toDomain() as List<Items>,
    );
  }
}
