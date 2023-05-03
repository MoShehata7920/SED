import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/settings_sub_screens/change_password_screen/viewmodel/change_password_screen_viewmodel.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import '../../../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../../../resources/assets_manager.dart';
import '../../../../../../resources/color_manager.dart';
import '../../../../../../resources/strings_manager.dart';

class ChangePasswordScreenView extends StatefulWidget {
  const ChangePasswordScreenView({super.key});

  @override
  State<ChangePasswordScreenView> createState() =>
      _ChangePasswordScreenViewState();
}

class _ChangePasswordScreenViewState extends State<ChangePasswordScreenView> {
  final ChangePasswordViewModel _viewModel = ChangePasswordViewModel();

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context, _buildContentWidget(), () => _viewModel) ??
              _buildContentWidget();
        },
      ),
    );
  }

  Widget _buildContentWidget() {
    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                AppPadding.p65, AppPadding.p65, AppPadding.p65, AppPadding.p65),
            child: Lottie.asset(JsonAssets.resetPassword)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
          child: StreamBuilder<String?>(
              // stream: _viewModel.outputErrorPasswordValid,
              builder: (context, snapshot) {
            return TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  hintText: AppStrings.oldPassword,
                  labelText: AppStrings.oldPassword,
                  errorMaxLines: 3,
                  errorText: snapshot.data, //else present the error to the user
                ));
          }),
        ),
        const SizedBox(
          height: AppSize.s25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
          child: StreamBuilder<String?>(
              // stream: _viewModel.outputErrorPasswordValid,
              builder: (context, snapshot) {
            return TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _newPasswordController,
                decoration: InputDecoration(
                  hintText: AppStrings.newPassword,
                  labelText: AppStrings.newPassword,
                  errorMaxLines: 3,
                  errorText: snapshot.data, //else present the error to the user
                ));
          }),
        ),
        const SizedBox(
          height: AppSize.s25,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
          child: StreamBuilder<String?>(
              // stream: _viewModel.outputErrorConfirmPasswordValid,
              builder: (context, snapshot) {
            return TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: _confirmNewPasswordController,
                decoration: InputDecoration(
                  hintText: AppStrings.rewriteNewPassword,
                  labelText: AppStrings.rewriteNewPassword,
                  errorMaxLines: 3,
                  errorText: snapshot.data, //else present the error to the user
                ));
          }),
        ),
        const SizedBox(
          height: AppSize.s32,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
          child: StreamBuilder<bool>(
              // stream: _viewModel.outputAreAllInputsValid,
              builder: (context, snapshot) {
            return SizedBox(
              width: double.infinity,
              height: AppSize.s40,
              child: ElevatedButton(
                  onPressed: (snapshot.data ?? false)
                      ? () {
                          // _viewModel.register();
                        }
                      : null,
                  child: Text(AppStrings.confirm)),
            );
          }),
        ),
      ]),
    );
  }
}
