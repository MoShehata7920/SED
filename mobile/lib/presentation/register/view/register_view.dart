import 'package:country_code_picker_mp/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:sed/presentation/register/viewmodel/register_viewmodel.dart';
import 'package:sed/presentation/resources/assets_manager.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import '../../../app/constants.dart';
import '../../../app/di.dart';
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

    _viewModel.isUserRegisteredSuccessfullyStreamController.stream
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
  void initState() {
    _bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
      ),
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
    return Container(
      padding: const EdgeInsets.only(top: AppPadding.p8),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Center(
                  child: Image(
                      image: AssetImage(ImageAssets.lightModeSplashLogo))),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorUserNameValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _userNameEditingController,
                          decoration: InputDecoration(
                            hintText: AppStrings.username,
                            labelText: AppStrings.username,
                            prefixIcon: Icon(
                              IconsManager.useName,
                              color: ColorManager.lightPrimary,
                            ),
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
                          flex: 1,
                          child: CountryCodePicker(
                            onChanged: (country) =>
                                _viewModel.setMobileCountryCode(
                                    country.code ?? Constants.token),
                            searchDecoration: InputDecoration(
                                hintText: AppStrings.countrySearchBar,
                                prefixIconColor: ColorManager.lightPrimary),
                            initialSelection: 'EG',
                            favorite: const ['EG'],
                            hideMainText: true,
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            showFlag: true,
                            padding: const EdgeInsets.all(AppPadding.p0),
                          )),
                      Expanded(
                        flex: 4,
                        child: StreamBuilder<String?>(
                            stream: _viewModel.outputErrorMobileNumberValid,
                            builder: (context, snapshot) {
                              return TextFormField(
                                  keyboardType: TextInputType.phone,
                                  controller: _mobileNumberEditingController,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.mobileNumber,
                                    labelText: AppStrings.mobileNumber,
                                    prefixIcon: Icon(
                                      IconsManager.phone,
                                      color: ColorManager.lightPrimary,
                                    ),
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
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorEmailValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailEditingController,
                          decoration: InputDecoration(
                            hintText: AppStrings.email,
                            labelText: AppStrings.email,
                            prefixIcon: Icon(
                              IconsManager.email,
                              color: ColorManager.lightPrimary,
                            ),
                            errorText: snapshot
                                .data, //else present the error to the user
                          ));
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: StreamBuilder<String?>(
                    stream: _viewModel.outputErrorPasswordValid,
                    builder: (context, snapshot) {
                      return TextFormField(
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordEditingController,
                          decoration: InputDecoration(
                            hintText: AppStrings.password,
                            labelText: AppStrings.password,
                            errorMaxLines: 3,
                            prefixIcon: Icon(
                              IconsManager.lock,
                              color: ColorManager.lightPrimary,
                            ),
                            errorText: snapshot
                                .data, //else present the error to the user
                          ));
                    }),
              ),
              const SizedBox(
                height: AppSize.s18,
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
                                    _viewModel.register();
                                  }
                                : null,
                            child: const Text(AppStrings.register)),
                      );
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: AppPadding.p8,
                  left: AppPadding.p18,
                  right: AppPadding.p18,
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    AppStrings.loginText,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
