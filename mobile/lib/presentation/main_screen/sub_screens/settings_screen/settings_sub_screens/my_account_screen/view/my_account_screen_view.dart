import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../../../../app/app_preferences.dart';
import '../../../../../../../app/di.dart';
import '../../../../../../resources/values_manager.dart';

class MyAccountScreenView extends StatefulWidget {
  const MyAccountScreenView({super.key});

  @override
  MyAccountScreenViewState createState() => MyAccountScreenViewState();
}

class MyAccountScreenViewState extends State<MyAccountScreenView> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final AppPreferences _appPreferences = instance<AppPreferences>();

  String? selectedCity;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _dobController = TextEditingController();
    _addressController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _dobController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryBackground,
        elevation: 0,
        iconTheme: IconThemeData(color: ColorsManager.secondaryText),
        title: Text(AppStrings.myAccount.tr(),
            style: TextStyle(color: ColorsManager.secondaryText)),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(AppStrings.profilePic.tr(),
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
                        backgroundImage: AssetImage(ImageAssets.noImage)),
                  ),
                  IconButton(
                    onPressed: () async {
                      final image = await Navigator.pushNamed(
                          context, Routes.cameraScreenRoute);
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
              Text(AppStrings.profileInfo.tr(),
                  style: TextStyle(
                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.primaryText)),
              const SizedBox(height: AppSize.s16),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: AppStrings.name.tr(),
                ),
              ),
              const SizedBox(height: AppSize.s8),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: AppStrings.phoneNumber.tr(),
                ),
              ),
              const SizedBox(height: AppSize.s8),
              DropdownButtonFormField<String>(
                value: selectedCity,
                decoration: InputDecoration(
                  labelText: AppStrings.selectGovernment.tr(),
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
                    selectedCity = selected;
                  });
                },
              ),
              const SizedBox(height: AppSize.s8),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  labelText: AppStrings.address.tr(),
                ),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(25),
                ],
                maxLengthEnforcement: MaxLengthEnforcement.enforced,
              ),
              const SizedBox(height: AppSize.s8),
              GestureDetector(
                child: TextField(
                  decoration: InputDecoration(
                      labelText: AppStrings.dob.tr(),
                      suffixIcon: const Icon(IconsManager.calender),
                      suffixIconColor: ColorsManager.primaryColor),
                  controller:
                      _dobController, //editing controller of this TextField
                  readOnly:
                      true, //set it true, so that user will not able to edit text
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            1900), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2040));

                    if (pickedDate != null) {
                      String formattedDate =
                          DateFormat('dd-MM-yyyy').format(pickedDate);

                      setState(() {
                        _dobController.text =
                            formattedDate; //set output date to TextField value.
                      });
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(AppStrings.changePassword.tr(),
                  style: TextStyle(
                      fontSize: AppSize.s20,
                      fontWeight: FontWeight.bold,
                      color: ColorsManager.primaryText)),
              const SizedBox(height: AppSize.s16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppStrings.oldPassword.tr(),
                ),
              ),
              const SizedBox(height: AppSize.s8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppStrings.newPassword.tr(),
                ),
              ),
              const SizedBox(height: AppSize.s8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: AppStrings.rewriteNewPassword.tr(),
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(AppStrings.saveChanges.tr()),
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
                    child: Text(AppStrings.logOut.tr()),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.deleteAccount.tr(),
                      style: TextStyle(color: ColorsManager.error),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
