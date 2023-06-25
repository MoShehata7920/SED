import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../viewmodel/camera_screen_viewmodel.dart';

class CameraScreenView extends StatefulWidget {
  const CameraScreenView({Key? key}) : super(key: key);

  @override
  CameraScreenViewState createState() => CameraScreenViewState();
}

class CameraScreenViewState extends State<CameraScreenView> {
  final CameraScreenViewModel _viewModel = CameraScreenViewModel();
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _viewModel.imageStream.listen((XFile image) {
      setState(() {
        _image = image;
      });
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
      appBar: AppBar(
        backgroundColor: ColorsManager.primaryBackground,
        elevation: 0,
        title: Text(
          AppStrings.uploadImage.tr(),
          style: TextStyle(color: ColorsManager.secondaryText),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: Stack(
              children: <Widget>[
                _image == null
                    ? Text(
                        AppStrings.noImageSelected.tr(),
                        style: TextStyle(
                          fontSize: AppSize.s18,
                          color: ColorsManager.primaryText,
                        ),
                      )
                    : Image.file(File(_image!.path)),
                if (_image != null)
                  Positioned(
                    bottom: AppMargin.m1,
                    right: AppMargin.m10,
                    child: IconButton(
                      icon: CircleAvatar(
                        radius: AppSize.s20,
                        backgroundColor: ColorsManager.primaryColor,
                        child: Icon(
                          IconsManager.done,
                          size: AppSize.s20,
                          color: ColorsManager.primaryText,
                        ),
                      ),
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context, _image);
                        // Perform the action you want when the "done" button is pressed.
                      },
                    ),
                  ),
              ],
            ),
          ),
          Positioned(
            bottom: AppMargin.m10,
            left: AppMargin.m10,
            child: Row(
              children: <Widget>[
                FloatingActionButton(
                  backgroundColor: ColorsManager.primaryColor,
                  onPressed: _viewModel.getImageFromCamera,
                  tooltip: AppStrings.takeAPhoto.tr(),
                  child: const Icon(IconsManager.camera),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                FloatingActionButton(
                  backgroundColor: ColorsManager.primaryColor,
                  onPressed: _viewModel.getImageFromGallery,
                  tooltip: AppStrings.selectFromGallery.tr(),
                  child: const Icon(IconsManager.gallery),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
