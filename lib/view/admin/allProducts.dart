import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:myshopp/view/sellview.dart';

import '../../constants.dart';
import '../../core/viewmodel/home_view_model.dart';
import '../../model/product_model.dart';
import '../../widgets/custom_text.dart';

class AdminProducts extends StatefulWidget {
  const AdminProducts({Key? key}) : super(key: key);

  @override
  State<AdminProducts> createState() => _AdminProductsState();
}
// one dev to role the all

class _AdminProductsState extends State<AdminProducts> {
  @override
  Widget build(BuildContext context) {
    // Get.put(ProfileViewModel());
    List<ProductModel> productsdata =
        Get.find<HomeViewModel>().products.toList();
    return Scaffold(
      body: Column(children: [
        Container(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, left: 16, right: 16),
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
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                CustomText(
                  text: 'all Products',
                  fontFamily: 'Baumans',
                  fontSize: 24,
                  alignment: Alignment.bottomCenter,
                ),
                Container(
                  width: 24,
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemBuilder: (_, index) => Column(
              children: [
                GestureDetector(
                  onTap: () {
                    // Get.to(ProductDetailView(id: productsdata[index].productId));
                  },
                  child: ListTile(
                    title: Text(productsdata[index].name),
                    leading: CircleAvatar(
                      radius: 30,
                    backgroundColor: Colors.white,
                      foregroundImage: NetworkImage(productsdata[index].image),
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(children: [
                      SizedBox(width: 45,),
                        IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: const Text('Are you Sure?'),
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
                                            print(
                                                productsdata[index].productId);
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
                const Divider()
              ],
            ),
            itemCount: productsdata.length,
          ),
        ),

        // Text(productsdata[0].name),
        // Text(productsdata[1].name)
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(SellView());
        },
        backgroundColor: primaryColor,
        child: const Icon(Icons.add),
      ),
    );
  }
}
