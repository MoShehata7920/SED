import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: ColorsManager.darkBlack,
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
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(ImageAssets.loginBackground)))),
        SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                    AppSize.s0, AppSize.s65, AppSize.s0, AppSize.s24),
                child: Image(
                  image: AssetImage(ImageAssets.loginDarkModeLoginLogo),
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
                          AppSize.s40, AppSize.s0, AppSize.s40, AppSize.s20),
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
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSize.s40, AppSize.s0, AppSize.s40, AppSize.s20),
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
                              color: ColorsManager.grayDark,
                              size: AppSize.s24,
                            ),
                          ),
                          errorText: (snapshot.data ??
                                  true) //check if the password was null
                              ? null //then no errors
                              : AppStrings
                                  .passwordError, //else present the error to the user
                        ),
                        style: TextStyle(color: ColorsManager.secondaryText),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSize.s40, AppSize.s0, AppSize.s40, AppSize.s20),
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
                        child: const Text(AppStrings.register)),
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
                        child: const Text(
                          AppStrings.forgetPassword,
                          style: TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSize.s0, AppSize.s12, AppSize.s0, AppSize.s0),
                child: Text(
                  AppStrings.useSocialToLoginText,
                  style: TextStyle(color: ColorsManager.secondaryText),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                    AppSize.s8, AppSize.s8, AppSize.s8, AppSize.s8),
                child: IconButton(
                  color: ColorsManager.grayIcon,
                  icon: const FaIcon(IconsManager.google),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
