import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sed/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/theme_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import '../../../app/di.dart';
import '../../common/google_authentication/view/google_authentication_view.dart';
import '../../common/state_renderer/state_renderer_impl.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final RegisterViewModel _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _userNameEditingController =
      TextEditingController();
  final TextEditingController _mobileNumberEditingController =
      TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _confirmPasswordEditingController =
      TextEditingController();

  //Initialize the controller

  _bind() {
    _viewModel.start();

    _userNameEditingController.addListener(() {
      _viewModel.setUserName(_userNameEditingController.text);
    });

    _mobileNumberEditingController.addListener(() {
      _viewModel.setMobileNumber(_mobileNumberEditingController.text);
    });

    _emailEditingController.addListener(() {
      _viewModel.setEmail(_emailEditingController.text);
    });

    _passwordEditingController.addListener(() {
      _viewModel.setPassword(_passwordEditingController.text);
    });

    _confirmPasswordEditingController.addListener(() {
      _viewModel.setConfirmPassword(_confirmPasswordEditingController.text);
    });

    _viewModel.isUserRegisteredSuccessfullyStreamController.stream
        .listen((isRegistered) {
      if (isRegistered) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context)
              .pushReplacementNamed(Routes.emailVerificationRoute);
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
                  context, _getContentWidget(), () => _viewModel.register()) ??
              _getContentWidget();
        },
      ),
    );
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
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p0,
                      AppPadding.p65, AppPadding.p0, AppPadding.p0),
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameEditingController,
                            decoration: InputDecoration(
                              hintText: AppStrings.username.tr(),
                              labelText: AppStrings.username.tr(),
                              errorText: snapshot
                                  .data, //else present the error to the user
                            ));
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Center(
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1, child: Image.asset(ImageAssets.egyptFlag)),
                        const SizedBox(
                          width: AppSize.s3,
                        ),
                        Expanded(
                          flex: 7,
                          child: StreamBuilder<String?>(
                              stream: _viewModel.outputErrorMobileNumberValid,
                              builder: (context, snapshot) {
                                return TextFormField(
                                    keyboardType: TextInputType.phone,
                                    controller: _mobileNumberEditingController,
                                    decoration: InputDecoration(
                                      hintText: AppStrings.mobileNumber.tr(),
                                      labelText: AppStrings.mobileNumber.tr(),
                                      errorText: snapshot
                                          .data, //else present the error to the user
                                    ));
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorEmailValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailEditingController,
                            decoration: InputDecoration(
                              hintText: AppStrings.email.tr(),
                              labelText: AppStrings.email.tr(),
                              errorText: snapshot
                                  .data, //else present the error to the user
                            ));
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _passwordEditingController,
                            obscureText: _viewModel.obscureText,
                            decoration: InputDecoration(
                              hintText: AppStrings.password.tr(),
                              labelText: AppStrings.password.tr(),
                              suffixIcon: InkWell(
                                focusNode: FocusNode(skipTraversal: true),
                                onTap: () {
                                  setState(() {
                                    _viewModel.togglePasswordVisibility();
                                  });
                                },
                                child: Icon(
                                  _viewModel.passwordSuffixIcon,
                                  color: ColorsManager.grayIcon,
                                  size: AppSize.s24,
                                ),
                              ),
                              errorMaxLines: 3,
                              errorText: snapshot
                                  .data, //else present the error to the user
                            ));
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<String?>(
                      stream: _viewModel.outputErrorConfirmPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _confirmPasswordEditingController,
                            obscureText: _viewModel.obscureText,
                            decoration: InputDecoration(
                              hintText: AppStrings.confirmPassword.tr(),
                              labelText: AppStrings.confirmPassword.tr(),
                              suffixIcon: InkWell(
                                focusNode: FocusNode(skipTraversal: true),
                                onTap: () {
                                  setState(() {
                                    _viewModel.togglePasswordVisibility();
                                  });
                                },
                                child: Icon(
                                  _viewModel.passwordSuffixIcon,
                                  color: ColorsManager.grayIcon,
                                  size: AppSize.s24,
                                ),
                              ),
                              errorMaxLines: 3,
                              errorText: snapshot
                                  .data, //else present the error to the user
                            ));
                      }),
                ),
                const SizedBox(
                  height: AppSize.s18,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outputAreAllInputsValid,
                      builder: (context, snapshot) {
                        return SizedBox(
                          width: double.infinity,
                          height: AppSize.s40,
                          child: ElevatedButton(
                              onPressed: (snapshot.data ?? false)
                                  ? () {
                                      _viewModel.register();
                                    }
                                  : null,
                              child: Text(AppStrings.register.tr())),
                        );
                      }),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.loginText.tr(),
                      style: TextStyle(color: ColorsManager.secondaryText),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        AppStrings.login.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(color: ColorsManager.primaryText),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p0,
                      AppPadding.p12, AppPadding.p0, AppPadding.p0),
                  child: Text(
                    AppStrings.useSocialToLoginText.tr(),
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
        ),
      ],
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
