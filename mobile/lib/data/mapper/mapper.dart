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

extension VerifyEmailResponseMapper on VerifyEmailResponse? {
  VerifyEMail toDomain() {
    return VerifyEMail();
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
          element?.id ?? "",
          element?.name ?? "",
          element?.image ?? "",
          element?.price ?? 0,
          element?.description ?? "",
          element?.condition ?? "",
          element?.category ?? "",
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
        this?.sections?.toDomain() as List<Section>,
        this?.notificationsCount ?? 0);
  }
}

extension ItemsResponseMapper on ItemsResponse? {
  Items toDomain() {
    return Items(
        this?.id ?? "",
        this?.name ?? "",
        this?.image ?? "",
        this?.price ?? 0,
        this?.description ?? "",
        this?.condition ?? "",
        this?.category ?? "",
        this?.date ?? "",
        this?.isSaved ?? false);
  }
}

extension UserDataResponseMapper on UserDataResponse? {
  UserData toDomain() {
    return UserData(this?.id ?? "", this?.name ?? "", this?.image ?? "",
        this?.phone ?? "", this?.government ?? "", this?.address ?? "");
  }
}

extension ItemResponseMapper on ItemResponse? {
  Item toDomain() {
    return Item(
        this?.product.toDomain() ?? Items("", "", "", 0, "", "", "", "", false),
        this?.user.toDomain() ?? UserData("", "", "", "", "", ""));
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
      this?.price ?? 0,
      this?.description ?? "",
      this?.purpose ?? "",
      this?.category ?? "",
      this?.condition ?? "",
      this?.token ?? "",
    );
  }
}

extension GetMyProfileMapper on GetMyProfileDataResponse? {
  GetMyProfileData toDomain() {
    return GetMyProfileData(
        this?.user.toDomain() ?? UserData("", "", "", "", "", ""));
  }
}

extension GetMyProfileAdsMapper on GetMyProfileAdsResponse? {
  GetMyProfileAds toDomain() {
    return GetMyProfileAds(this?.items?.toDomain() ?? <Items>[]);
  }
}

extension RemoveAdMapper on RemoveAdResponse? {
  RemoveAd toDomain() {
    return RemoveAd(
      this?.itemId ?? 0,
    );
  }
}

extension UpdateAdMapper on UpdateAdResponse? {
  UpdateAd toDomain() {
    return UpdateAd(
      this?.itemId ?? 0,
      this?.image ?? "",
      this?.name ?? "",
      this?.price ?? 0,
      this?.description ?? "",
      this?.purpose ?? "",
      this?.category ?? "",
      this?.condition ?? "",
      this?.token ?? "",
    );
  }
}

extension NotificationMapper on List<NotificationResponse>? {
  List<Notification> toDomain() {
    List<Notification> notification = [];

    this?.forEach((element) {
      notification.add(Notification(
          element.id ?? 0,
          element.title ?? "",
          element.description ?? "",
          element.dateTime ?? DateTime.now(),
          element.isSeen ?? false));
    });

    return notification;
  }
}

extension NotificationsMapper on NotificationsResponse? {
  Notifications toDomain() {
    return Notifications(this?.notifications.toDomain() ?? []);
  }
}

extension SearchResponseMapper on SearchResponse? {
  ShowItems toDomain() {
    return this?.searchedProducts.toDomain() ?? ShowItems([]);
  }
}

extension DefaultResponseMapper on DefaultResponse? {
  Default toDomain() {
    return Default();
  }
}

extension NewConversationMapper on NewConversationResponse? {
  NewConversation toDomain() {
    return NewConversation(this?.savedConversation?.conversationId ?? "");
  }
}

extension GetAllConversationsMapper on GetAllConversationsResponse? {
  GetAllConversations toDomain() {
    List<ConversationsData> temp = [];

    this?.conversations?.forEach((element) {
      temp.add(
          ConversationsData(element?.conversationId ?? "", element?.usersData.toDomain() ?? []));
    });

    return GetAllConversations(temp);
  }
}

extension GetUserDataMapper on List<UserDataResponse?>? {
  List<UserData> toDomain() {
    List<UserData> tempUserData = [];

    this?.forEach((element) {
      tempUserData.add(UserData(element?.id ?? "", element?.name ?? "",
          element?.image ?? "", "", "", ""));
    });

    return tempUserData;
  }
}

extension GetChatMessagesMapper on GetChatMessagesResponse? {
  GetChatMessages toDomain() {
    List<Messages> temp = [];

    this?.messages?.forEach((element) {
      temp.add(
          Messages(element?.conversationId ?? "", element?.senderId ?? "",element?.text ?? "", element?.createdAt ?? ""));
    });

    return GetChatMessages(temp);
  }
}

extension NewMessageMapper on NewMessageResponse? {
  NewMessage toDomain() {
    return NewMessage(Message(this?.savedMessage?.conversationId ?? "", this?.savedMessage?.senderId ?? "",this?.savedMessage?.text ?? ""));
  }
}