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
class Home {
  Carousel carousel;
  List<Category> category;
  List<Items> sellItems;
  List<Items> donateItems;
  List<Items> exchangeItems;

  Home(this.carousel, this.category, this.sellItems, this.donateItems, this.exchangeItems);
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

  Items(this.id, this.name, this.image, this.price, this.description, this.categoryId, this.date);
}

class Item {
  Items item;
  UserData userData;

  Item(this.item, this.userData);
}

class UserData {
  String name;
  String phone;
  String address;
  String image;

  UserData(this.name, this.phone, this.address, this.image);
}