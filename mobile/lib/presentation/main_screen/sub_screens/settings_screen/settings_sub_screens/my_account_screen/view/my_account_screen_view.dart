import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/presentation/main_screen/sub_screens/settings_screen/settings_sub_screens/my_account_screen/viewmodel/my_account_screen_viewmodel.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../../../../app/app_preferences.dart';
import '../../../../../../../app/di.dart';
import '../../../../../../common/state_renderer/state_renderer_impl.dart';
import '../../../../../../resources/values_manager.dart';

class MyAccountScreenView extends StatefulWidget {
  const MyAccountScreenView({super.key});

  @override
  MyAccountScreenViewState createState() => MyAccountScreenViewState();
}

class MyAccountScreenViewState extends State<MyAccountScreenView> {
  final MyAccountViewModel _viewModel = MyAccountViewModel();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _governmentController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  String? selectedCity;

  XFile? _image;

  _bind() async {
    await _viewModel.start(); //start the view model job

    if (_viewModel.userData != null) {
      _nameController.text = _viewModel.userData!.user.name;
      _phoneController.text = _viewModel.userData!.user.phone;
      _addressController.text = _viewModel.userData!.user.address;

      if (_viewModel.userData!.user.government.isNotEmpty) {
        selectedCity = _viewModel.userData!.user.government;
      }

      //_viewModel.userProfileObject.copyWith(userImage: _viewModel.userData!.user.image);
    }
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
    _governmentController = TextEditingController();
    _addressController = TextEditingController();
    _passwordController = TextEditingController();

    _nameController.addListener(() {
      _viewModel.setUserName(_nameController.text);
    });

    _phoneController.addListener(() {
      _viewModel.setMobileNumber(_phoneController.text);
    });

    _governmentController.addListener(() {
      _viewModel.setUserGovernment(_governmentController.text);
    });

    _addressController.addListener(() {
      _viewModel.setAddress(_addressController.text);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bind();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _governmentController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.secondaryText),
        title: Text(AppStrings.myAccount,
            style: TextStyle(color: ColorsManager.secondaryText)),
      ),
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
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(AppStrings.profilePic,
                style: TextStyle(
                    fontSize: AppSize.s20,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.primaryText)),
            const SizedBox(height: AppSize.s16),
            Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                CircleAvatar(
                  radius: AppSize.s52,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  child: CircleAvatar(
                      backgroundColor: ColorsManager.primaryBackground,
                      radius: AppSize.s50,
                      backgroundImage: _image != null
                          ? FileImage(File(_image!.path)) as ImageProvider
                          : NetworkImage(_viewModel.userData != null
                              ? _viewModel.userData!.user.image
                              : "")),
                ),
                IconButton(
                  onPressed: () async {
                    final image = await Navigator.pushNamed(
                        context, Routes.cameraScreenRoute);
                    setState(() {
                      _image = image as XFile;

                      if (_image != null) {
                        File imageFile = File(_image!.path);

                        _viewModel.userProfileObject = _viewModel
                            .userProfileObject
                            .copyWith(userImage: imageFile);
                      }
                    });
                  },
                  icon: const CircleAvatar(
                    radius: AppSize.s16,
                    child: Icon(
                      IconsManager.update,
                      size: AppSize.s16,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSize.s24),
            Text(AppStrings.profileInfo,
                style: TextStyle(
                    fontSize: AppSize.s20,
                    fontWeight: FontWeight.bold,
                    color: ColorsManager.primaryText)),
            const SizedBox(height: AppSize.s16),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: AppStrings.name,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: AppStrings.phoneNumber,
              ),
            ),
            const SizedBox(height: AppSize.s8),
            DropdownButtonFormField<String>(
              value: selectedCity,
              decoration: InputDecoration(
                labelText: AppStrings.selectGovernment,
              ),
              dropdownColor: ColorsManager.primaryBackground,
              items: AppStrings.governments.map((String government) {
                return DropdownMenuItem<String>(
                  value: government,
                  child: Text(government),
                );
              }).toList(),
              onChanged: (String? selected) {
                setState(() {
                  _governmentController.text = selected ?? "";
                  selectedCity = selected;
                });
              },
            ),
            const SizedBox(height: AppSize.s8),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: AppStrings.address,
              ),
              inputFormatters: [
                LengthLimitingTextInputFormatter(50),
              ],
              maxLengthEnforcement: MaxLengthEnforcement.enforced,
            ),
            // const SizedBox(height: AppSize.s8),
            // Text(AppStrings.changePassword.tr(),
            //     style: TextStyle(
            //         fontSize: AppSize.s20,
            //         fontWeight: FontWeight.bold,
            //         color: ColorsManager.primaryText)),
            // const SizedBox(height: AppSize.s16),
            // TextField(
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: AppStrings.oldPassword.tr(),
            //   ),
            // ),
            // const SizedBox(height: AppSize.s8),
            // TextField(
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: AppStrings.newPassword,
            //   ),
            // ),
            // const SizedBox(height: AppSize.s8),
            // TextField(
            //   controller: _passwordController,
            //   obscureText: true,
            //   decoration: InputDecoration(
            //     labelText: AppStrings.rewriteNewPassword,
            //   ),
            // ),
            const SizedBox(height: AppSize.s16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _viewModel.updateUserProfile();
                },
                child: Text(AppStrings.saveChanges),
              ),
            ),
            const SizedBox(height: AppSize.s16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      _appPreferences.setUserLoggedInSuccessfully(false);
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.loginRoute);
                    });
                  },
                  child: Text(AppStrings.logOut),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.deleteAccount,
                    style: TextStyle(color: ColorsManager.error),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
