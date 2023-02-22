import 'package:flutter/material.dart';
import 'package:sed/presentation/forgot_password/viewmodel/forgotpassword_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';

import '../../resources/assets_manager.dart';
import '../../resources/values_manager.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final ForgotPasswordViewModel _viewModel = ForgotPasswordViewModel();

  void _bind() {
    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void initState() {
    _bind();
  }

  @override
  Widget build(BuildContext context) {
    return _getContentWidget();
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
                // todo, change
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: ColorManager.lightPrimary,
                            ),
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
              // todo change
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
              //   child: StreamBuilder<bool>(
              //       stream: _viewModel.outAreAllInputsValid,
              //       builder: (context, snapshot) {
              //         return SizedBox(
              //           width: double.infinity,
              //           height: AppSize.s40,
              //           child: ElevatedButton(
              //               onPressed: (snapshot.data ?? false)
              //                   ? () {
              //                       _viewModel.login();
              //                     }
              //                   : null,
              //               child: const Text(AppStrings.login)),
              //         );
              //       }),
              // ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p18,
                  right: AppPadding.p18,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          AppStrings.resendText,
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
