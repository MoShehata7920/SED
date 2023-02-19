const String imagePath = 'assets/images';

const String jsonPath = 'assets/json';
class ImageAssets {
  //splash screen
  static const String lightModeSplashLogo = '$imagePath/light_mode_logo.png';

  //onboarding screen
  static const List<String> onBoardingLogos = [
    "$imagePath/onboarding_logo1.svg",
    "$imagePath/onboarding_logo2.svg",
    "$imagePath/onboarding_logo3.svg",
  ];

  static const String leftArrowIcon = "$imagePath/left_arrow_icon.svg";
  static const String rightArrowIcon = "$imagePath/right_arrow_icon.svg";
  static const String hollowCircleIcon = "$imagePath/hollow_circle_icon.svg";
  static const String solidCircleIcon = "$imagePath/solid_circle_icon.svg";
}

class JsonAssets {
  //state renderer
  static const String loading = "$jsonPath/loading.json";
  static const String error = "$jsonPath/error.json";
  static const String empty = "$jsonPath/empty.json";
}