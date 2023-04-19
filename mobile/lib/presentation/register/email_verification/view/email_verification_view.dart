import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/color_manager.dart';
import '../../../resources/strings_manager.dart';
import '../../../resources/values_manager.dart';

class EmailVerificationScreenView extends StatefulWidget {
  const EmailVerificationScreenView({super.key});

  @override
  State<EmailVerificationScreenView> createState() =>
      _EmailVerificationScreenViewState();
}

class _EmailVerificationScreenViewState
    extends State<EmailVerificationScreenView> {
  final TextEditingController _digitsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.primaryBackground,
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p65,
                  AppPadding.p65, AppPadding.p65, AppPadding.p65),
              child: Lottie.asset(JsonAssets.verificationOTP)),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Text(
              AppStrings.verifyYourEmail,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.primaryText,
                    fontSize: AppSize.s20,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text(
              AppStrings.enterOtp,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: ColorsManager.secondaryText,
                    fontSize: AppSize.s15,
                  ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: PinCodeTextField(
              appContext: context,
              length: 6,
              animationType: AnimationType.fade,
              validator: (v) {
                if (v!.length < 3) {
                  return "I'm from validator";
                } else {
                  return null;
                }
              },
              backgroundColor: ColorsManager.primaryBackground,
              textStyle: TextStyle(color: ColorsManager.primaryText),
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.underline,
                activeFillColor: ColorsManager.primaryColor,
                inactiveColor: ColorsManager.secondaryText,
              ),
              cursorColor: ColorsManager.primaryText,
              animationDuration: const Duration(milliseconds: 300),
              // errorAnimationController: errorController,
              controller: _digitsController,
              keyboardType: TextInputType.number,
              onCompleted: (v) {
                debugPrint("Completed");
              },
              // onTap: () {
              //   print("Pressed");
              // },
              onChanged: (value) {
                debugPrint(value);
                setState(() {
                  // currentText = value;
                });
              },
              beforeTextPaste: (text) {
                debugPrint("Allowing to paste $text");
                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                return true;
              },
            ),
          ),
          Center(
              child: TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.resendCode,
                    style: TextStyle(color: ColorsManager.primaryColor),
                  ))),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
                AppPadding.p40, AppPadding.p10, AppPadding.p40, AppPadding.p20),
            child: SizedBox(
                width: double.infinity,
                height: AppSize.s40,
                child: ElevatedButton(
                    onPressed: () {}, child: const Text(AppStrings.submit))),
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _digitsController.dispose();
    super.dispose();
  }
}
