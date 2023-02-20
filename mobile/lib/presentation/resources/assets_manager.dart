const String imagePath = 'assets/images';

const String jsonPath = 'assets/json';

class ImageAssets {
  //splash screen
  static const String lightModeSplashLogo = '$imagePath/light_mode_logo.png';

  static const String leftArrowIcon = "$imagePath/left_arrow_icon.svg";
  static const String rightArrowIcon = "$imagePath/right_arrow_icon.svg";
  static const String hollowCircleIcon = "$imagePath/hollow_circle_icon.svg";
  static const String solidCircleIcon = "$imagePath/solid_circle_icon.svg";
}

class JsonAssets {
  //onboarding screen
  static const List<String> onBoardingLogos = [
    "$jsonPath/on_boarding_sell.json",
    "$jsonPath/on_boarding_exchange.json",
    "$jsonPath/on_boarding_donate.json",
  ];
  //state renderer
  static const String loading = "$jsonPath/loading.json";
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
}
