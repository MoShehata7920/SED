import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:sed/presentation/forgot_password/reset_password/viewmodel/reset_password_viewmodel.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import '../../../common/state_renderer/state_renderer_impl.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final ResetPasswordViewmodel _viewModel = ResetPasswordViewmodel();

  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  void initState() {
    _newPasswordController.addListener(
        () => _viewModel.setNewPassword(_newPasswordController.text));

    _confirmNewPasswordController.addListener(() =>
        _viewModel.setConfirmNewPassword(_confirmNewPasswordController.text));
    super.initState();

    _viewModel.isUserRestedPasswordSuccessfullyStreamController.stream
        .listen((isRegistered) {
      if (isRegistered) {
        // navigate to main screen
        SchedulerBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushReplacementNamed(Routes.mainScreenRoute);
        });
      }
    });
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                context,
                _buildContentWidget(),
                () => _viewModel,
              ) ??
              _buildContentWidget();
        },
      ),
    );
  }

  Widget _buildContentWidget() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppPadding.p65,
              AppPadding.p65,
              AppPadding.p65,
              AppPadding.p65,
            ),
            child: Lottie.asset(JsonAssets.resetPassword),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
            child: StreamBuilder<String?>(
              stream: _viewModel.outputErrorNewPasswordValid,
              builder: (context, snapshot) {
                return TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _newPasswordController,
                  decoration: InputDecoration(
                    hintText: AppStrings.newPassword.tr(),
                    labelText: AppStrings.newPassword.tr(),
                    errorMaxLines: 3,
                    errorText:
                        snapshot.data, //else present the error to the user
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: AppSize.s25,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
            child: StreamBuilder<String?>(
              stream: _viewModel.outputErrorConfirmNewPasswordValid,
              builder: (context, snapshot) {
                return TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: _confirmNewPasswordController,
                  decoration: InputDecoration(
                    hintText: AppStrings.rewriteNewPassword.tr(),
                    labelText: AppStrings.rewriteNewPassword.tr(),
                    errorMaxLines: 3,
                    errorText:
                        snapshot.data, //else present the error to the user
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: AppSize.s32,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
            child: StreamBuilder<bool>(
              stream: _viewModel.outputAreAllInputsValid,
              builder: (context, snapshot) {
                return SizedBox(
                  width: double.infinity,
                  height: AppSize.s40,
                  child: ElevatedButton(
                    onPressed: (snapshot.data ?? false)
                        ? () {
                            _viewModel.resetPassword();
                          }
                        : null,
                    child: Text(AppStrings.confirm.tr()),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
