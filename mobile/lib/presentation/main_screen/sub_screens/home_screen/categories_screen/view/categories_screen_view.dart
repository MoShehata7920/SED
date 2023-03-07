import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/color_manager.dart';

class CategoriesScreenView extends StatefulWidget {
  const CategoriesScreenView({super.key});

  @override
  State<CategoriesScreenView> createState() => _CategoriesScreenViewState();
}

class _CategoriesScreenViewState extends State<CategoriesScreenView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.lightGrey,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 1/1.2,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(5, (index) => _getItemWidget(index))),
          ],
        ),
      ),
    );
  }

  Widget _getItemWidget(index) {
    return Card(
      child: Column(children: [
        Flexible(
          flex: 2,
          child: Image(
            image: NetworkImage(
                "https://www.i2clipart.com/cliparts/5/5/a/2/clipart-gown-512x512-55a2.png"),
          ),
        ),
        Flexible(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fashion',
                        style: TextStyle(
                          color: ColorManager.thirdLightPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '+5000 ads',
                      ),
                    ]),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                color: Colors.lightBlue.withOpacity(0.1),
              ),
              height: 50,
            ),
          ),
        )
      ]),
    );
  }
}
