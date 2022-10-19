import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:myshopp/core/viewmodel/SellViewModel.dart';
import 'package:myshopp/model/product_model.dart';
import 'package:myshopp/view/product_details_view.dart';

import '../constants.dart';
import '../core/viewmodel/home_view_model.dart';
import '../core/viewmodel/profile_viewmodel.dart';
import '../widgets/custom_text.dart';

class UserProduct extends StatefulWidget {
  const UserProduct({Key? key}) : super(key: key);

  @override
  State<UserProduct> createState() => _UserProductState();
}

class _UserProductState extends State<UserProduct> {
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileViewModel());
    late String? sellerId = Get.find<ProfileViewModel>().currentUser!.userId;
    List<ProductModel> productsdata = Get.find<HomeViewModel>()
        .products
        .where((meal) => meal.sellerId == sellerId)
        .toList();
    return Scaffold(
        backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
        body: SingleChildScrollView(
          child: Column(children: [
            Container(
              height: 100,
              child: Padding(
                padding: EdgeInsets.only(bottom: 24, left: 16, right: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                    CustomText(
                      text: 'Your Products',
                      fontSize: 20,
                      alignment: Alignment.bottomCenter,
                    ),
                    Container(
                      width: 24,
                    ),
                  ],
                ),
              ),
            ),
            productsdata.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/caart.svg',
                        width: 350,
                        height: 350,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      CustomText(
                        text: "Your Favorites will show here... ",
                        fontSize: 23,
                        alignment: Alignment.topCenter,
                      )
                    ],
                  )
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (_, index) => Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(ProductDetailView(
                                id: productsdata[index].productId));
                          },
                          child: ListTile(
                            title: Text(productsdata[index].name),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage:
                                  NetworkImage(productsdata[index].image),
                            ),
                            trailing: Container(
                              width: 100,
                              child: Row(children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: primaryColor,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              title:
                                                  const Text('Are you Sure?'),
                                              content: const Text(
                                                'Do u want to remove the product from the shop',
                                              ),
                                              actions: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: const Text('No'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    print(productsdata[index]
                                                        .productId);
                                                    Get.find<HomeViewModel>()
                                                        .deleteProductsFromFireStore(
                                                            productsdata[index]
                                                                .productId);
                                                    setState(() {});
                                                    Get.back();
                                                  },
                                                  child: const Text('Yes'),
                                                ),
                                              ],
                                            )));
                                  },
                                  icon: Icon(
                                    CupertinoIcons.delete,
                                    color: Theme.of(context).errorColor,
                                  ),
                                ),
                              ]),
                            ),
                          ),
                        ),
                        Divider()
                      ],
                    ),
                    itemCount: productsdata.length,
                  ),
            // Text(productsdata[0].name),
            // Text(productsdata[1].name)
          ]),
        ));
  }
}
