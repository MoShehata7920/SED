import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sed/presentation/main_screen/utils/utils.dart';

import '../../../../resources/color_manager.dart';

class AddProductView extends StatefulWidget {
  const AddProductView({super.key});

  @override
  State<AddProductView> createState() => _AddProductViewState();
}

class _AddProductViewState extends State<AddProductView> {
  List<DropdownMenuItem<dynamic>> dropDownItems = <DropdownMenuItem<dynamic>>[];
  int? _selectedValue;
  final ImagePicker _picker = ImagePicker();

  // for selecting sell,exchange or donate
  final List<Text> _addProcessingType = <Text>[
    Text('Sell'),
    Text('Exchange'),
    Text('Donate')
  ];
  final List<bool> _selectedProcessingType = <bool>[false, false, true];

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
        backgroundColor: ColorManager.lightGrey,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                  ColorManager.lightPrimary,
                  ColorManager.thirdLightPrimary
                ])),
          ),
          leading: IconButton(
            icon: Icon(Icons.close, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Add an advertisement"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  color: Colors.white,
                  width: double.infinity,
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_circle_rounded,
                          color: ColorManager.lightPrimary),
                      SizedBox(
                        width: 1,
                      ),
                      Text(
                        "Add image",
                        style: TextStyle(color: ColorManager.lightPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: double.infinity,
                  child: ToggleButtons(
                    isSelected: _selectedProcessingType,
                    onPressed: (int index) {
                      setState(() {
                        // The button that is tapped is set to true, and the others to false.
                        for (int i = 0;
                            i < _selectedProcessingType.length;
                            i++) {
                          _selectedProcessingType[i] = i == index;
                        }
                      });
                    },
                    selectedBorderColor: ColorManager.secondLightPrimary,
                    selectedColor: ColorManager.white,
                    fillColor: ColorManager.fifthLightPrimary,
                    color: ColorManager.lightPrimary,
                    children: _addProcessingType,
                  )),
              SizedBox(
                height: 10,
              ),
              Container(
                color: ColorManager.white,
                width: double.infinity,
                height: 40,
                child: DropdownButton(
                    hint: const Text("Category"),
                    underline: Container(),
                    icon: Icon(Icons.category_rounded),
                    iconEnabledColor: ColorManager.thirdLightPrimary,
                    isExpanded: true,
                    value: _selectedValue,
                    items: dropDownItems,
                    onChanged: (dynamic x) {
                      setState(() {
                        _selectedValue = x;
                      });
                    }),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ));
  }
}
