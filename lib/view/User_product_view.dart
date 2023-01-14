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
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: AppBar(
            elevation: 0,
            flexibleSpace: Container(
              height: 400,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    // Color.fromRGBO(131, 217, 226, 1),
                    // Color.fromRGBO(162, 230, 209, 1),
                    Color.fromRGBO(12, 116, 117, 1),
                    Color.fromRGBO(14, 174, 87, 1),
                  ],
                ),
              ),
              child: const Padding(
                padding: EdgeInsets.only(top: 20.0),
                child: Center(
                    child: Text(
                  'Your Products',
                  style: TextStyle(
                      fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
                )),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            productsdata.length == 0
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/caart.svg',
                        width: 350,
                        height: 350,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      CustomText(
                        fontFamily: 'Baumans',
                        text: "Start selling your products now ... ",
                        fontSize: 24,
                        alignment: Alignment.topCenter,
                      )
                    ],
                  )
                : Stack(children: [
                    Container(
                      height: MediaQuery.of(context).size.height * .06,
                      // one dev to role the all

                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            // Color.fromRGBO(131, 217, 226, 1),
                            // Color.fromRGBO(162, 230, 209, 1),
                            Color.fromRGBO(12, 116, 117, 1),
                            Color.fromRGBO(14, 174, 87, 1),
                          ],
                        ),
                      ),
                    ),
                    Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          ),
                        ),
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              ListView.builder(
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
                                          backgroundImage: NetworkImage(
                                              productsdata[index].image),
                                        ),
                                        trailing: Container(
                                          width: 100,
                                          child: Row(children: [
                                            IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.edit,
                                                color: primaryColor,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 0,
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: ((context) =>
                                                        AlertDialog(
                                                          title: const Text(
                                                              'Are you Sure?'),
                                                          content: const Text(
                                                            'Do u want to remove the product from the shop',
                                                          ),
                                                          actions: [
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  'No'),
                                                            ),
                                                            ElevatedButton(
                                                              onPressed: () {
                                                                print(productsdata[
                                                                        index]
                                                                    .productId);
                                                                Get.find<
                                                                        HomeViewModel>()
                                                                    .deleteProductsFromFireStore(
                                                                        productsdata[index]
                                                                            .productId);
                                                                setState(() {});
                                                                Get.back();
                                                              },
                                                              child: const Text(
                                                                  'Yes'),
                                                            ),
                                                          ],
                                                        )));
                                              },
                                              icon: Icon(
                                                CupertinoIcons.delete,
                                                color: Theme.of(context)
                                                    .errorColor,
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
                            ],
                          ),
                          // Text(productsdata[0].name),
                          // Text(productsdata[1].name)
                        ))
                  ])
          ]),
        ));
  }
}
