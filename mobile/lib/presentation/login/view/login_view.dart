import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sed/app/app_preferences.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
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
      backgroundColor: ColorsManager.dark900,
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
    return Align(
      key: _formKey,
      alignment: const AlignmentDirectional(-0.14, -0.08),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            color: Color(0x19444D59),
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(ImageAssets.loginBackground))),
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 90.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 24.0),
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
                          40.0, 0.0, 40.0, 20.0),
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryBackground,
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 20.0, 0.0),
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
                                  : AppStrings
                                      .emailInValid, //else present the error to the user
                            ),
                            style: TextStyle(color: ColorsManager.tertiary),
                          ),
                        ),
                      ),
                    );
                  }),
              Padding(
                padding:
                    const EdgeInsetsDirectional.fromSTEB(40.0, 0.0, 40.0, 20.0),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsPasswordValid,
                    builder: (context, snapshot) {
                      return Container(
                        width: double.infinity,
                        height: AppSize.s50,
                        decoration: BoxDecoration(
                          color: ColorsManager.primaryBackground,
                          borderRadius: BorderRadius.circular(AppSize.s25),
                        ),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              12.0, 0.0, 20.0, 0.0),
                          child: TextFormField(
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
                                child: Icon(
                                  _viewModel.passwordSuffixIcon,
                                  color: ColorsManager.grayDark,
                                  size: AppSize.s24,
                                ),
                                focusNode: FocusNode(skipTraversal: true),
                                onTap: () {
                                  setState(() {
                                    //TODO change it to stream builder or use bloc
                                    _viewModel.togglePasswordVisibility();
                                  });
                                },
                              ),
                              errorText: (snapshot.data ??
                                      true) //check if the password was null
                                  ? null //then no errors
                                  : AppStrings
                                      .passwordError, //else present the error to the user
                            ),
                            style: TextStyle(color: ColorsManager.tertiary),
                          ),
                        ),
                      );
                    }),
              ),

              // FIXME stat from here @Bimbum1337 

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
