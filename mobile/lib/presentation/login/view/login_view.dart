import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sed/presentation/login/viewmodel/login_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

import '../../resources/assets_manager.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginViewModel _viewModel = LoginViewModel(_loginUseCase);

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
  }

  @override
  void initState() {
    _bind();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: AppPadding.p100),
        color: ColorManager.white,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outIsUserNameValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _userNameController,
                            decoration: InputDecoration(
                              hintText: AppStrings.username,
                              labelText: AppStrings.username,
                              errorText: (snapshot.data ??
                                      true) //check if the username was null
                                  ? null //then no errors
                                  : AppStrings
                                      .usernameError, //else present the error to the user
                            ));
                      }),
                ),
                const SizedBox(
                  height: AppSize.s28,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outIsPasswordValid,
                      builder: (context, snapshot) {
                        return TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            controller: _userPasswordController,
                            decoration: InputDecoration(
                              hintText: AppStrings.password,
                              labelText: AppStrings.password,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                  child: StreamBuilder<bool>(
                      stream: _viewModel.outIsUserNameValid,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                            onPressed: () {
                              _viewModel.login();
                            },
                            child: const Text(AppStrings.login));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
