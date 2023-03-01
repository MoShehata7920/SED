import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
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

  final _formKey = GlobalKey<FormState>();

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
          _appPreferences.setUserLoggedInSuccessfully();
          Navigator.of(context).pushReplacementNamed(Routes.mainScreenRoute);
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
      backgroundColor: ColorManager.white,
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
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p100),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                  child: Image(
                      image: AssetImage(ImageAssets.lightModeSplashLogo))),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameController,
                          decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            prefixIcon: Icon(
                              IconsManager.email,
                              color: ColorManager.lightPrimary,
                            ),
                            errorText: (snapshot.data ??
                                    true) //check if the username was null
                                ? null //then no errors
                                : AppStrings
                                    .emailInValid, //else present the error to the user
                          ));
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
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
                            suffixIcon: GestureDetector(
                              child: Icon(
                                _viewModel.passwordSuffixIcon,
                                color: ColorManager.lightPrimary,
                              ),
                              onTap: () {
                                setState(() {
                                  //TODO change it to stream builder or use bloc
                                  _viewModel.togglePasswordVisibility();
                                });
                              },
                            ),
                            prefixIcon: Icon(
                              IconsManager.lock,
                              color: ColorManager.lightPrimary,
                            ),
                            errorText: (snapshot.data ??
                                    true) //check if the password was null
                                ? null //then no errors
                                : AppStrings
                                    .passwordError, //else present the error to the user
                          ));
                    }),
              ),
              const SizedBox(
                height: AppSize.s28,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
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
                            child: const Text(AppStrings.login)),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p18,
                  right: AppPadding.p18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordRoute);
                        },
                        child: Text(
                          AppStrings.forgetPassword,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.registerRoute);
                        },
                        child: Text(
                          AppStrings.registerText,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
