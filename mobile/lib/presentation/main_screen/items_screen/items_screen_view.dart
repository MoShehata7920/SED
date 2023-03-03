import 'package:flutter/material.dart';
import 'package:sed/presentation/resources/color_manager.dart';
import 'package:sed/presentation/resources/icons_manager.dart';
import 'package:sed/presentation/resources/strings_manager.dart';
import 'package:sed/presentation/resources/values_manager.dart';

class Product {
  final String name;
  final String brand;
  final String imageURL;
  final int price;

  Product(this.name, this.brand, this.imageURL, this.price);

  factory Product.fromJson(Map<String, dynamic> json) {
    return new Product(
        json["name"], json["brand"], json["imageURL"], json["price"]);
  }
}

class ProductViewPage extends StatefulWidget {
  final Product product;
  const ProductViewPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductViewPageState createState() => _ProductViewPageState();
}

class _ProductViewPageState extends State<ProductViewPage> {
  List<dynamic> productList = [];
  List<String> size = [
    "S",
    "M",
    "L",
    "XL",
  ];

  List<Color> colors = [
    Colors.black,
    Colors.purple,
    Colors.orange.shade200,
    Colors.blueGrey,
    Color(0xFFFFC1D9),
  ];

  int _selectedColor = 0;
  int _selectedSize = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          expandedHeight: MediaQuery.of(context).size.height * 0.6,
          elevation: AppSize.s0,
          snap: true,
          floating: true,
          stretch: true,
          backgroundColor: Colors.grey.shade50,
          flexibleSpace: FlexibleSpaceBar(
              stretchModes: const [
                StretchMode.zoomBackground,
              ],
              background: Image.network(
                widget.product.imageURL,
                fit: BoxFit.cover,
              )),
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(AppSize.s45),
              child: Transform.translate(
                offset: const Offset(AppSize.s0, AppSize.s1),
                child: Container(
                  height: AppSize.s45,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppSize.s30),
                      topRight: Radius.circular(AppSize.s30),
                    ),
                  ),
                  child: Center(
                      child: Container(
                    width: AppSize.s50,
                    height: AppSize.s8,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(AppSize.s10),
                    ),
                  )),
                ),
              )),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Container(
              height: MediaQuery.of(context).size.height,
              color: ColorManager.white,
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSize.s20, vertical: AppSize.s5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.product.name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            color: Colors.black.withOpacity(.2),
                            child: Text(
                              widget.product.brand,
                              style: TextStyle(
                                color: ColorManager.thirdLightPrimary,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$ " + widget.product.price.toString() + '.00',
                        style: const TextStyle(
                            color: Colors.black, fontSize: AppSize.s16),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Take a break from jeans with the parker long straight pant. These lightweight, pleat front pants feature a flattering high waist and loose, straight legs.",
                    style: TextStyle(
                      height: AppSize.s1_5,
                      color: Colors.grey.shade800,
                      fontSize: AppSize.s14,
                    ),
                  ),
                  const SizedBox(
                    height: AppSize.s12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        IconsManager.location,
                        size: AppSize.s12,
                        color: ColorManager.grey2,
                      ),
                      Expanded(
                        child: Text(
                          'Gharbiya / Tanta',
                          textAlign: TextAlign.start,
                          maxLines: AppValues.maxAddressLines,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: AppSize.s14, color: ColorManager.grey2),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "item.date,",
                          textAlign: TextAlign.end,
                          maxLines: AppValues.maxDateLines,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: AppSize.s14, color: ColorManager.grey2),
                        ),
                      ),
                    ],
                  ),
                  const Divider(
                    height: AppSize.s20,
                  ),
                  Text(
                    AppStrings.user,
                    style: TextStyle(
                        color: Colors.grey.shade400, fontSize: AppSize.s18),
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: AppSize.s28,
                        backgroundImage: NetworkImage(
                            "https://th.bing.com/th/id/R.733a9c9b0f5252d2c21f33f5a60a9de7?rik=wiZ31M7KSXjoWA&pid=ImgRaw&r=0"),
                      ),
                      const SizedBox(
                        width: AppSize.s14,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mahmoud Hafez"),
                            const SizedBox(
                              height: AppSize.s5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("+201060945735"),
                                TextButton(
                                  child: Text(
                                    AppStrings.showProfile,
                                    style: TextStyle(
                                        color: ColorManager.secondLightPrimary),
                                  ),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: TextButton.icon(
                      style: TextButton.styleFrom(
                        textStyle:
                            TextStyle(color: ColorManager.secondLightPrimary),
                        backgroundColor: ColorManager.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s24),
                        ),
                      ),
                      onPressed: () => {},
                      icon: Icon(
                        IconsManager.chat,
                        color: ColorManager.secondLightPrimary,
                      ),
                      label: Text(AppStrings.chat,
                          style: TextStyle(
                            color: ColorManager.secondLightPrimary,
                          )),
                    ),
                  ),
                  const Divider(
                    height: AppSize.s14,
                  )
                ],
              ))
        ])),
      ]),
    );
  }
}
