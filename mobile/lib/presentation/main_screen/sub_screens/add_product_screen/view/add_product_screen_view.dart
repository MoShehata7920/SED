import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';
import 'package:toggle_switch/toggle_switch.dart';
import '../../../../resources/color_manager.dart';

class AddProductView extends StatefulWidget {
  AddProductView(this.categoryId, {super.key});

  int categoryId;

  @override
  State<AddProductView> createState() => _AddProductViewState(categoryId);
}

class _AddProductViewState extends State<AddProductView> {
  int categoryId;
  int selectedIndex = 0;

  _AddProductViewState(this.categoryId);

  List<DropdownMenuItem<dynamic>> dropDownItems = <DropdownMenuItem<dynamic>>[];
  final ImagePicker _picker = ImagePicker();

  // for selecting sell,exchange or donate

  @override
  void initState() {
    for (var element in Utils.categories) {
      var dropDownItem = DropdownMenuItem(
        value: element.id,
        child: Text(element.name),
      );

      dropDownItems.add(dropDownItem);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            AppStrings.addAdvertizement,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: ColorsManager.lineColor,
                  fontSize: AppSize.s20,
                ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: AppSize.s150,
                  decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(AppSize.s20)),
                    color: ColorsManager.secondaryBackground,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_rounded,
                          color: ColorsManager.lineColor),
                      const SizedBox(
                        width: AppSize.s2,
                      ),
                      Text(
                        AppStrings.addImage,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: ColorsManager.lineColor,
                              fontSize: AppSize.s14,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s25,
                ),
                Text(
                  AppStrings.selectedCategory,
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
                      onPressed: () {},
                      child: Text(
                        AppStrings.change,
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
                  AppStrings.selectSection,
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
                    totalSwitches: AppStrings.appSections.length,
                    labels: [
                      AppStrings.appSections[0],
                      AppStrings.appSections[1],
                      AppStrings.appSections[2]
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
                  AppStrings.condition,
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
                    labels: const [AppStrings.newItem, AppStrings.used],
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
                  AppStrings.name,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s10,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: AppStrings.productName,
                    filled: true,
                    fillColor: ColorsManager.secondaryBackground,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.primaryBtnText,
                        fontSize: AppSize.s15,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.price,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s10,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: AppStrings.productPrice,
                    filled: true,
                    fillColor: ColorsManager.secondaryBackground,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.primaryBtnText,
                        fontSize: AppSize.s15,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Text(
                  AppStrings.description,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.white,
                        fontSize: AppSize.s10,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s12,
                ),
                TextFormField(
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: AppStrings.productDescription,
                    filled: true,
                    fillColor: ColorsManager.secondaryBackground,
                  ),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: ColorsManager.primaryBtnText,
                        fontSize: AppSize.s15,
                      ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text(AppStrings.submit)),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
              ],
            ),
          ),
        ));
  }
}
