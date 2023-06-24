import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/common/google_authentication/view/google_authentication_view.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/theme_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import '../../resources/assets_manager.dart';
import '../../resources/routes_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = instance<LoginViewModel>();
  final AppPreferences _appPreferences = instance<AppPreferences>();

  final TextEditingController _userNameController = TextEditingController();

  final TextEditingController _userPasswordController = TextEditingController();

  _bind() {
    _viewModel.start(); //start the view model job

    _userNameController.addListener(() => _viewModel.setUserName(
        _userNameController
            .text)); //updating the username on change happening to the text

    _userPasswordController.addListener(() => _viewModel.setPassword(
        _userPasswordController
            .text)); //updating the password on change happening to the text

    _viewModel.isUserLoggedInSuccessfullyStreamController.stream
        .listen((isLoggedIn) {
      if (isLoggedIn) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (_viewModel.isVerified) {
            _appPreferences.setUserLoggedInSuccessfully(true);
            Navigator.of(context).pushReplacementNamed(Routes.mainScreenRoute);
          } else {
            Navigator.of(context)
                .pushReplacementNamed(Routes.emailVerificationRoute);
          }
        });
      }
    });
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context, _getContentWidget(), () => _viewModel.login()) ??
              _getContentWidget();
        },
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget() {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: ThemeManager.isDarkMode
                        ? const AssetImage(ImageAssets.loginBackgroundDarkMode)
                        : const AssetImage(
                            ImageAssets.loginBackgroundLightMode)))),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p0,
                    AppPadding.p65, AppPadding.p0, AppPadding.p25),
                child: Image(
                  image: ThemeManager.isDarkMode
                      ? const AssetImage(
                          ImageAssets.loginDarkModeLoginLogoDarkMode)
                      : const AssetImage(
                          ImageAssets.loginDarkModeLoginLogoLightMode),
                  width: AppSize.s160,
                  height: AppSize.s140,
                  fit: BoxFit.cover,
                ),
              ),
              StreamBuilder<bool>(
                  stream: _viewModel.outIsUserNameValid,
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(
                          AppPadding.p40,
                          AppPadding.p0,
                          AppPadding.p40,
                          AppPadding.p20),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: _userNameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: AppStrings.email,
                          labelStyle: TextStyle(
                              fontSize: AppSize.s14,
                              color: ColorsManager.secondaryText),
                          labelText: AppStrings.email,
                          errorText: (snapshot.data ??
                                  true) //check if the username was null
                              ? null //then no errors
                              : AppStrings.emailInValid,
                          //else present the error to the user
                        ),
                        style: TextStyle(color: ColorsManager.secondaryText),
                      ),
                    );
                  }),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p40,
                    AppPadding.p0, AppPadding.p40, AppPadding.p20),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        controller: _userPasswordController,
                        obscureText: _viewModel.obscureText,
                        decoration: InputDecoration(
                          hintText: AppStrings.password,
                          labelText: AppStrings.password,
                          labelStyle: TextStyle(
                              fontSize: AppSize.s14,
                              color: ColorsManager.secondaryText),
                          suffixIcon: InkWell(
                            focusNode: FocusNode(skipTraversal: true),
                            onTap: () {
                              setState(() {
                                _viewModel.togglePasswordVisibility();
                              });
                            },
                            child: Icon(
                              _viewModel.passwordSuffixIcon,
                              color: ColorsManager.secondaryText,
                              size: AppSize.s24,
                            ),
                          ),
                          errorText: (snapshot.data ??
                                  true) //check if the password was null
                              ? null //then no errors
                              : AppStrings.passwordError
                                  .tr(), //else present the error to the user
                        ),
                        style: TextStyle(color: ColorsManager.secondaryText),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p40,
                    AppPadding.p0, AppPadding.p40, AppPadding.p20),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outAreAllInputsValid,
                    builder: (context, snapshot) {
                      return SizedBox(
                        width: double.infinity,
                        height: AppSize.s40,
                        child: ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.login();
                                  }
                                : null,
                            child: Text(AppStrings.login)),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 5,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.primaryColor,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(AppStrings.register)),
                  ),
                  const SizedBox(
                    width: AppSize.s10,
                  ),
                  Flexible(
                    flex: 6,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ColorsManager.dark900,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p0,
                    AppPadding.p12, AppPadding.p0, AppPadding.p0),
                child: Text(
                  AppStrings.useSocialToLoginText,
                  style: TextStyle(color: ColorsManager.secondaryText),
                ),
              ),
              const Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(AppPadding.p8,
                      AppPadding.p8, AppPadding.p8, AppPadding.p8),
                  child: SignInDemo()),
            ],
          ),
        ),
      ],
    );
  }
}
