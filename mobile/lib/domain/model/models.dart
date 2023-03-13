// onBoarding Models
class SliderObject {
  String title;
  String subTitle;
  String image;

  SliderObject(this.title, this.subTitle, this.image);
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}

// Login models
class Authentication {
  String? token;

  Authentication(this.token);
}

// ForgotPassword models
class ForgotPassword {
  String? support;

  ForgotPassword(this.support);
}

// Home models

class HomeContentObject {
  List<String?> carouselImages;
  List<Items> sellItems;
  List<Items> donateItems;
  List<Items> exchangeItems;
  List<Section> sections;

  HomeContentObject(this.carouselImages, this.sellItems, this.donateItems,
      this.exchangeItems, this.sections);
}

class Home {
  Carousel carousel;
  List<Category> category;
  List<Items> sellItems;
  List<Items> donateItems;
  List<Items> exchangeItems;
  List<Section> sections;

  Home(this.carousel, this.category, this.sellItems, this.donateItems,
      this.exchangeItems, this.sections);
}

class Section {
  int id;
  String name;
  String image;

  Section(this.id, this.name, this.image);
}

class Carousel {
  List<String?> images;

  Carousel(this.images);
}

class Category {
  int id;
  String name;
  String image;

  Category(this.id, this.name, this.image);
}

class Items {
  int id;
  String name;
  String image;
  int price;
  String description;
  String date;
  int categoryId;
  bool isSaved;

  Items(this.id, this.name, this.image, this.price, this.description,
      this.categoryId, this.date, this.isSaved);
}

// Show Items Models

class ShowItemsContentObject {
  List<Items> items;

  ShowItemsContentObject(this.items);
}

// Item Screen Models (Contains Item Information)

class Item {
  Items item;
  UserData userData;

  Item(this.item, this.userData);
}

class UserData {
  int id;
  String name;
  String phone;
  String address;
  String image;

  UserData(this.id, this.name, this.phone, this.address, this.image);
}

class ShowItems {
  List<Items> items;

  ShowItems(this.items);
}

//Show Profile Models

class ShowProfileRequest {
  int profileId;

  ShowProfileRequest(this.profileId);
}

class SavingProduct {
  bool savingProductStatus;

  SavingProduct(this.savingProductStatus);
}

// Add Advertisement
class AddAdvertisement {
  String image;
  String name;
  String price;
  String description;
  int sectionId;
  int categoryId;
  int conditionId;

  AddAdvertisement(this.image, this.name, this.price, this.description,
      this.sectionId, this.categoryId, this.conditionId);
}

// My Profile Models
class GetMyProfileData {
  UserData user;

  GetMyProfileData(this.user);
}

class MyProfileDataContentObject {
  UserData user;

  MyProfileDataContentObject(this.user);
}