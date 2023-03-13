import 'package:sed/app/constants.dart';
import 'package:sed/app/extensions.dart';
import 'package:sed/data/responses/responses.dart';
import 'package:sed/domain/model/models.dart';

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
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
          element?.id ?? 0,
          element?.name ?? "",
          element?.image ?? "",
          element?.price ?? 0,
          element?.description ?? "",
          element?.categoryId ?? 0,
          element?.date ?? "",
          element?.isSaved ?? false));
    });

    return temporary;
  }
}

extension SectionMapper on List<SectionResponse?>? {
  List<Section> toDomain() {
    List<Section> temporary = [];

    this?.forEach((element) {
      temporary.add(
          Section(element?.id ?? 0, element?.name ?? "", element?.image ?? ""));
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
        this?.sections?.toDomain() as List<Section>);
  }
}

extension ItemsResponseMapper on ItemsResponse? {
  Items toDomain() {
    return Items(
        this?.id ?? 0,
        this?.name ?? "",
        this?.image ?? "",
        this?.price ?? 0,
        this?.description ?? "",
        this?.categoryId ?? 0,
        this?.date ?? "",
        this?.isSaved ?? false);
  }
}

extension UserDataResponseMapper on UserDataResponse? {
  UserData toDomain() {
    return UserData(this?.id ?? 0, this?.name ?? "", this?.phone ?? "",
        this?.address ?? "", this?.image ?? "");
  }
}

extension ItemResponseMapper on ItemResponse? {
  Item toDomain() {
    return Item(this?.item.toDomain() ?? Items(0, "", "", 0, "", 0, "", false),
        this?.user.toDomain() ?? UserData(0, "", "", "", ""));
  }
}

extension ShowItemsResponseMapper on ShowItemsResponse? {
  ShowItems toDomain() {
    return ShowItems(this?.showItems?.toDomain() ?? <Items>[]);
  }
}

extension SavingProductResponseMapper on SavingProductResponse? {
  SavingProduct toDomain() {
    return SavingProduct(this?.savingProductStatus ?? false);
  }
}

extension AddAdvertisementMapper on AddAdvertisementResponse? {
  AddAdvertisement toDomain() {
    return AddAdvertisement(
      this?.image ?? "",
      this?.name ?? "",
      this?.price ?? "",
      this?.description ?? "",
      this?.sectionId ?? 0,
      this?.categoryId ?? 0,
      this?.conditionId ?? 0,
    );
  }
}

extension GetMyProfileMapper on GetMyProfileDataResponse? {
  GetMyProfileData toDomain() {
    return GetMyProfileData(
        this?.user.toDomain() ?? UserData(0, "", "", "", ""));
  }
}
