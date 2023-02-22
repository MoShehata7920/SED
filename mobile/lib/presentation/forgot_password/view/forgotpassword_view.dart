import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/forgot_password/viewmodel/forgotpassword_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
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

  final ForgotPasswordViewModel _viewModel =
      instance<ForgotPasswordViewModel>();

  bind() {
    _viewModel.start(); //start the view model job

    _emailController
        .addListener(() => _viewModel.setEmail(_emailController.text));
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  @override
  void initState() {
    bind();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(context, _getContentWidget(),
                  () => _viewModel.forgotPassword()) ??
              _getContentWidget();
        },
      ),
    );
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<bool>(
                    stream: _viewModel.outIsEmailValid,
                    builder: (context, snapshotValidation) {
                      return StreamBuilder(
                          stream: _viewModel.outShowResend,
                          builder: (context, snapshotResend) {
                            bool show = (snapshotResend.data ?? false) as bool;
                            if (show) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: AppPadding.p8,
                                  left: AppPadding.p18,
                                  right: AppPadding.p18,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _viewModel.getResendText(),
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox(
                                width: double.infinity,
                                height: AppSize.s40,
                                child: ElevatedButton(
                                    onPressed:
                                        (snapshotValidation.data ?? false)
                                            ? () {
                                                _viewModel.forgotPassword();
                                              }
                                            : null,
                                    child:
                                        const Text(AppStrings.resetPassword)),
                              );
                            }
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
