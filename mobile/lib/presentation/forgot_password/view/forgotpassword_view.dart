import 'package:flutter/material.dart';
import 'package:sed/app/di.dart';
import 'package:sed/presentation/forgot_password/viewmodel/forgotpassword_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../common/state_renderer/state_renderer_impl.dart';
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
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryBackground,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.chevron_left_rounded,
            color: ColorsManager.primaryText,
            size: AppSize.s32,
          ),
        ),
        title: const Text(
          AppStrings.forgetPassword,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: AppSize.s20,
          ),
        ),
        centerTitle: false,
        elevation: AppSize.s0,
      ),
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
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSize.s20, AppSize.s20, AppSize.s20, AppSize.s0),
              child: StreamBuilder<bool>(
                  stream: _viewModel.outIsEmailValid,
                  builder: (context, snapshot) {
                    return TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        obscureText: false,
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: AppStrings.email,
                          labelText: AppStrings.email,
                          labelStyle: TextStyle(
                              fontSize: AppSize.s14,
                              color: ColorsManager.secondaryText),
                          filled: true,
                          fillColor: ColorsManager.secondaryBackground,
                          errorText: (snapshot.data ??
                                  true) //check if the username was null
                              ? null //then no errors
                              : AppStrings
                                  .emailInValid, //else present the error to the user
                        ));
                  }),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSize.s0, AppSize.s24, AppSize.s0, AppSize.s0),
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
                              width: AppSize.s230,
                              height: AppSize.s50,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: ColorManager.white,
                                  ),
                                  onPressed:
                                      (snapshotValidation.data ?? false)
                                          ? () {
                                              _viewModel.forgotPassword();
                                            }
                                          : null,
                                  child: Text(
                                    AppStrings.resetPassword,
                                    style: TextStyle(
                                        fontSize: AppSize.s16,
                                        fontWeight: FontWeight.w500,
                                        color: ColorsManager
                                            .secondaryBackground),
                                  )),
                            );
                          }
                        });
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
