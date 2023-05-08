// onBoarding Models
import 'dart:io';

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

class VerifyEMail {}

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
  int notificationsCount;
  Home(this.carousel, this.category, this.sellItems, this.donateItems,
      this.exchangeItems, this.sections, this.notificationsCount);
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
  String id;
  String name;
  String image;
  int price;
  String description;
  String condition;
  String date;
  String category;
  bool isSaved;

  Items(this.id, this.name, this.image, this.price, this.description,
      this.condition, this.category, this.date, this.isSaved);
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
  String id;
  String name;
  String image;
  String phone;
  String government;
  String address;

  UserData(this.id, this.name, this.image, this.phone, this.government,
      this.address);
}

class ShowItems {
  List<Items> items;

  ShowItems(this.items);
}

//Show Profile Models

class ShowProfileRequest {
  String profileId;

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
  int price;
  String description;
  String purpose;
  String category;
  String condition;
  String token;

  AddAdvertisement(this.image, this.name, this.price, this.description,
      this.purpose, this.category, this.condition, this.token);
}

class Default {}

// My Profile Models
class GetMyProfileData {
  UserData user;

  GetMyProfileData(this.user);
}

class GetMyProfileAds {
  List<Items> items;

  GetMyProfileAds(this.items);
}

class RemoveAd {
  int itemId;

  RemoveAd(this.itemId);
}

class UpdateAd {
  int itemId;
  String image;
  String name;
  int price;
  String description;
  String purpose;
  String category;
  String condition;
  String token;

  UpdateAd(this.itemId, this.image, this.name, this.price, this.description,
      this.purpose, this.category, this.condition, this.token);
}

class UpdateUserProfile {
  String userId;
  File userImage;
  String name;
  String phoneNumber;
  String government;
  String address;
  String password;

  UpdateUserProfile(this.userId, this.userImage, this.name, this.phoneNumber,
      this.government, this.address, this.password);
}

class ChangePassword {
  String userId;
  String oldPassword;
  String newPassword;
  String confirmNewPassword;

  ChangePassword(
      this.userId, this.oldPassword, this.newPassword, this.confirmNewPassword);
}

class Notification {
  int id;
  String title;
  String description;
  DateTime dateTime;
  bool isSeen;

  Notification(
      this.id, this.title, this.description, this.dateTime, this.isSeen);
}

class Notifications {
  List<Notification> notifications;

  Notifications(this.notifications);
}

class User {
  final String id;
  final String fullName;
  final String email;
  final String createdAt;

  User(
      {required this.id,
      required this.fullName,
      required this.email,
      required this.createdAt});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      fullName: json['fullName'],
      email: json['email'],
      createdAt: json['createdAt'],
    );
  }
}

// Chat
class NewConversation {
  String senderId;
  String receiverId;

  NewConversation(this.senderId, this.receiverId);
}

class SavedConversation {
  String conversationId;

  SavedConversation(this.conversationId);
}

class GetAllConversations {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isSeen;

  GetAllConversations(
      this.id, this.title, this.description, this.dateTime, this.isSeen);
}

class Conversations {
  String id;
  String title;
  String description;
  DateTime dateTime;
  bool isSeen;

  Conversations(
      this.id, this.title, this.description, this.dateTime, this.isSeen);
}
