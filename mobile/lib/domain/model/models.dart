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
  List<String?> carouselImages;

  Home(this.carouselImages);
}
