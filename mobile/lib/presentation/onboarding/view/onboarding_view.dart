import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/common/animation_manager/animation_,manager.dart';
import 'package:sed/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/constants_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import '../../../domain/model/models.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  _bind() {
    _appPreferences.setOnBoardingScreenViewed();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
        stream: _viewModel.outputSliderViewObject,
        builder: (context, snapshot) {
          return _getContentWidget(snapshot.data);
        });
  }

  Widget _getContentWidget(SliderViewObject? sliderObject) {
    if (sliderObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorsManager.darkBlack,
        body: PageView.builder(
            controller: _pageController,
            itemCount: sliderObject.numOfSlides,
            onPageChanged: (index) {
              _viewModel.onPageChanged(index);
            },
            itemBuilder: (context, index) {
              return OnBoardingPage(sliderObject.sliderObject);
            }),
        bottomSheet: Container(
          color: ColorsManager.darkBlack,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _getBottomSheetWidget(
                  sliderObject) // widgets indicator and arrows
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {
    return Container(
      color: ColorsManager.darkBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // left arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.leftArrowIcon),
              ),
              onTap: () {
                // go to previous slide
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),

          // circles indicator
          Row(
            children: [
              for (int i = 0; i < sliderViewObject.numOfSlides; i++)
                Padding(
                  padding: const EdgeInsets.all(AppPadding.p8),
                  child: _getProperCircles(i, sliderViewObject.currentIndex),
                ),
            ],
          ),

          // right arrow
          Padding(
            padding: const EdgeInsets.all(AppPadding.p14),
            child: GestureDetector(
              child: SizedBox(
                width: AppSize.s20,
                height: AppSize.s20,
                child: SvgPicture.asset(ImageAssets.rightArrowIcon),
              ),
              onTap: () {
                // go to previous slide
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                        milliseconds: AppConstants.sliderAnimationTime),
                    curve: Curves.bounceInOut);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getProperCircles(int index, int currentIndex) {
    if (index == currentIndex) {
      return SvgPicture.asset(ImageAssets.solidCircleIcon);
    } else {
      return SvgPicture.asset(ImageAssets.hollowCircleIcon);
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject _sliderObject;

  const OnBoardingPage(this._sliderObject, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: AppSize.s20,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: AppSize.s30,
                top: AppSize.s30,
                right: AppSize.s15,
              ),
              child: Image.asset(
                ImageAssets.onBoardingLogo,
                width: AppSize.s60,
                height: AppSize.s60,
                fit: BoxFit.fill,
              ),
            ).animateOnPageLoad(msDelay: 50, dx: 71.0, dy: 0, showDelay: 900),
            Padding(
              padding: const EdgeInsets.only(
                top: AppSize.s45,
              ),
              child: Text(
                AppStrings.sed,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: AppSize.s25, color: ColorsManager.white),
              ).animateOnPageLoad(
                  msDelay: 150, dx: -74.0, dy: 0, showDelay: 900),
            )
          ],
        ),
        const SizedBox(
          height: AppSize.s100,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p28),
          child: Text(
            'Find Your\nFavorite Hotel\nTo Stay',
            textAlign: TextAlign.start,
            style: Theme.of(context)
                .textTheme
                .displayLarge
                ?.copyWith(fontSize: AppSize.s38, height: AppSize.s1_5),
          ),
        ).animateOnPageLoad(msDelay: 150, dx: 71.0, dy: 0, showDelay: 900),
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.only(left: AppSize.s20, right: AppSize.s20),
          child: Text(
            _sliderObject.subTitle,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ).animateOnPageLoad(msDelay: 400, dx: 71.0, dy: 0, showDelay: 900),
        const SizedBox(
          height: AppSize.s60,
        ),
        const SizedBox(
          height: AppSize.s18,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
          child: SizedBox(
            width: double.infinity,
            height: AppSize.s40,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.registerRoute);
                },
                child: const Text(AppStrings.register)),
          ).animateOnPageLoad(msDelay: 550, dx: -79.0, dy: 0, showDelay: 900),
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.loginText,
              style: TextStyle(color: ColorsManager.secondaryText),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.loginRoute);
              },
              child: Text(
                AppStrings.login,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: ColorManager.white),
              ),
            ),
          ],
        ).animateOnPageLoad(msDelay: 650, dx: -74.0, dy: 0, showDelay: 600),
      ],
    );
  }
}
