import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/domain/model/models.dart';
import 'package:sed/presentation/common/state_renderer/state_renderer_impl.dart';
import 'package:sed/presentation/main_screen/sub_screens/add_product_screen/viewmodel/add_advertisement_screen_viewmodel.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/routes_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../resources/color_manager.dart';

class AddAdvertisementView extends StatefulWidget {
  AddAdvertisementView(this.categoryId, this.item, {super.key});

  int categoryId;
  Items? item;
  @override
  State<AddAdvertisementView> createState() =>
      // ignore: no_logic_in_create_state
      _AddAdvertisementViewState(categoryId, item);
}

class _AddAdvertisementViewState extends State<AddAdvertisementView> {
  int categoryId;
  int selectedIndex = 0;
  Items? item;

  final AddAdvertisementViewModel _viewModel = AddAdvertisementViewModel();

  _AddAdvertisementViewState(this.categoryId, this.item);

  List<DropdownMenuItem<dynamic>> dropDownItems = <DropdownMenuItem<dynamic>>[];
  final ImagePicker _imagePicker = ImagePicker();

  // for selecting sell,exchange or donate
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _viewModel.start();

    _nameController.addListener(() => _viewModel.setName(_nameController.text));

    _priceController
        .addListener(() => _viewModel.setPrice(_priceController.text));

    _descriptionController.addListener(
        () => _viewModel.setDescription(_descriptionController.text));

    if (item != null) {
      _nameController.text = item!.name;
      _priceController.text = item!.price.toString();
      _descriptionController.text = item!.description;

      selectedIndex = 0;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsManager.darkBlack,
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) {
          return snapshot.data?.getScreenWidget(
                  context, _getContentWidget(), () => () {}) ??
              _getContentWidget();
        },
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();

    super.dispose();
  }

  Widget _getContentWidget() {
    return Scaffold(
        backgroundColor: ColorsManager.primaryBackground,
        appBar: AppBar(
          backgroundColor: ColorsManager.primaryBackground,
          elevation: 0,
          leading: IconButton(
              icon: Icon(
                IconsManager.close,
                color: ColorsManager.white,
              ),
              onPressed: () => Navigator.pushReplacementNamed(
                  context, Routes.mainScreenRoute)),
          title: Text(
            AppStrings.addAdvertisement.tr(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorsManager.lineColor,
                  fontSize: AppSize.s20,
                ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  child: _getImage(),
                  onTap: () async {
                    var image = await _imagePicker.pickImage(
                        source: ImageSource.gallery);
                    _viewModel.setImage(image);
                  },
                ),
                const SizedBox(
                  height: AppSize.s25,
                ),
                Text(
                  AppStrings.selectedCategory.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s16,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s15,
                ),
                Row(
                  children: [
                    Container(
                      height: AppSize.s55,
                      width: AppSize.s55,
                      decoration: BoxDecoration(
                          color: ColorsManager.secondaryBackground,
                          shape: BoxShape.circle),
                      child: Center(
                        child: FaIcon(
                          IconsManager.categoriesIcons[categoryId],
                          color: ColorsManager.secondaryText,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s20,
                    ),
                    Text(
                      Utils.categories[categoryId].name,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: ColorsManager.secondaryText,
                            fontSize: AppSize.s16,
                          ),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, Routes.categoriesScreenRoute);
                      },
                      child: Text(
                        AppStrings.change.tr(),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.primaryColor,
                              fontSize: AppSize.s12,
                            ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Divider(
                  height: AppSize.s1,
                  color: ColorsManager.lineColor,
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.selectSection.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s16,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ToggleSwitch(
                    customWidths: [
                      MediaQuery.of(context).size.width / 3 - (40 / 3),
                      MediaQuery.of(context).size.width / 3 - (40 / 3),
                      MediaQuery.of(context).size.width / 3 - (40 / 3)
                    ],
                    initialLabelIndex: selectedIndex,
                    cornerRadius: AppSize.s20,
                    activeFgColor: Colors.white,
                    inactiveBgColor: ColorsManager.secondaryBackground,
                    inactiveFgColor: ColorsManager.primaryText,
                    totalSwitches: AppValues.appSections,
                    labels: [
                      AppStrings.sellProducts.tr(),
                      AppStrings.exchange.tr(),
                      AppStrings.donate.tr()
                    ],
                    dividerColor: ColorsManager.alternate,
                    activeBgColors: [
                      [ColorsManager.primaryColor],
                      [ColorsManager.alternate],
                      [ColorsManager.primaryColor],
                    ],
                    onToggle: (index) {
                      setState(() {
                        selectedIndex = index ?? 0;
                      });
                    },
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Divider(
                  height: AppSize.s1,
                  color: ColorsManager.lineColor,
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.condition.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s16,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Center(
                  child: ToggleSwitch(
                    minWidth: AppSize.s90,
                    cornerRadius: AppSize.s20,
                    activeBgColors: [
                      [ColorsManager.alternate],
                      [ColorsManager.error]
                    ],
                    activeFgColor: ColorsManager.white,
                    inactiveBgColor: ColorsManager.secondaryBackground,
                    inactiveFgColor: ColorsManager.white,
                    initialLabelIndex: 0,
                    totalSwitches: 2,
                    labels: [AppStrings.newItem.tr(), AppStrings.used.tr()],
                    radiusStyle: true,
                    onToggle: (index) {},
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Divider(
                  height: AppSize.s1,
                  color: ColorsManager.lineColor,
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.name.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s10,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                StreamBuilder<bool>(
                    stream: _viewModel.isNameValidOutput,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: AppStrings.productName.tr(),
                          filled: true,
                          fillColor: ColorsManager.secondaryBackground,
                          errorText: (snapshot.data ??
                                  true) //check if the password was null
                              ? null //then no errors
                              : AppStrings.fieldError.tr(),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.primaryBtnText,
                              fontSize: AppSize.s15,
                            ),
                      );
                    }),
                const SizedBox(
                  height: AppSize.s20,
                ),
                if (selectedIndex == 0) _getPriceWidget(),
                Text(
                  AppStrings.description.tr(),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s10,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                StreamBuilder<bool>(
                    stream: _viewModel.isDescriptionValidOutput,
                    builder: (context, snapshot) {
                      return TextFormField(
                        controller: _descriptionController,
                        obscureText: false,
                        decoration: InputDecoration(
                          hintText: AppStrings.productDescription.tr(),
                          filled: true,
                          fillColor: ColorsManager.secondaryBackground,
                          errorText: (snapshot.data ??
                                  true) //check if the password was null
                              ? null //then no errors
                              : AppStrings.fieldError.tr(),
                        ),
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.primaryBtnText,
                              fontSize: AppSize.s15,
                            ),
                      );
                    }),
                const SizedBox(
                  height: AppSize.s20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: StreamBuilder<bool>(
                      stream: _viewModel.areAllInputsValidOutput,
                      builder: (context, snapshot) {
                        return ElevatedButton(
                            onPressed: (snapshot.data ?? false)
                                ? () {
                                    _viewModel.setIds(
                                        selectedIndex + 1, categoryId + 1, 0);
                                    if (item == null) {
                                      _viewModel.addAdvertisement(context);
                                    } else {
                                      _viewModel.updateAd(context, item!.id);
                                    }
                                  }
                                : null,
                            child: Text(AppStrings.submit.tr()));
                      }),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
              ],
            ),
          ),
        ));
  }

  Widget _getImage() {
    return StreamBuilder<String>(
      stream: _viewModel.imageOutput,
      builder: (context, snapshot) {
        return Container(
            height: AppSize.s150,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.all(Radius.circular(AppSize.s20)),
              color: ColorsManager.secondaryBackground,
            ),
            child: item == null
                ? snapshot.data == null
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_circle_rounded,
                              color: ColorsManager.lineColor),
                          const SizedBox(
                            width: AppSize.s2,
                          ),
                          Text(
                            AppStrings.addImage.tr(),
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: ColorsManager.lineColor,
                                      fontSize: AppSize.s14,
                                    ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius:
                            BorderRadius.circular(AppSize.s20), // Image border
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(AppSize.s48),
                          child: Image.file(
                            File(snapshot.data!),
                            fit: BoxFit.fill,
                          ),
                        ),
                      )
                : ClipRRect(
                    borderRadius:
                        BorderRadius.circular(AppSize.s20), // Image border
                    child: SizedBox.fromSize(
                      size: const Size.fromRadius(AppSize.s48),
                      child: Image.network(
                        item!.image,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ));
      },
    );
  }

  Widget _getPriceWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.price.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: ColorsManager.white,
                fontSize: AppSize.s10,
              ),
        ),
        const SizedBox(
          height: AppSize.s15,
        ),
        StreamBuilder<bool>(
            stream: _viewModel.isPriceValidOutput,
            builder: (context, snapshot) {
              return TextFormField(
                keyboardType: TextInputType.number,
                controller: _priceController,
                obscureText: false,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  hintText: AppStrings.productPrice.tr(),
                  filled: true,
                  fillColor: ColorsManager.secondaryBackground,
                  errorText:
                      (snapshot.data ?? true) //check if the password was null
                          ? null //then no errors
                          : AppStrings.fieldError.tr(),
                ),
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: ColorsManager.primaryBtnText,
                      fontSize: AppSize.s15,
                    ),
              );
            }),
        const SizedBox(
          height: AppSize.s20,
        ),
      ],
    );
  }
}
