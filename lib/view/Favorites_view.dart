import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/Favorites_%20view_model.dart';
import 'package:myshopp/core/viewmodel/cart_view_model.dart';
import 'package:myshopp/widgets/custom_button.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../core/viewmodel/checkoutview_model.dart';
import 'checkout_view.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(FavoritesviewModel());
    return GetBuilder<FavoritesviewModel>(
      init: Get.put(FavoritesviewModel()),
      builder: (controller) => Scaffold(
        body: controller.favoritesProductModel.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/empty.gif',
                    width: 350,
                    height: 350,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    text: "Your  Cart is empty... ",
                    fontSize: 23,
                    alignment: Alignment.topCenter,
                  )
                ],
              )
            : 
              
                Column(
                    children: [
                      

                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(top: 50, right: 16, left: 16),
                          child: ListView.separated(
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                height: 20,
                              );
                            },
                            itemBuilder: (context, index) {
                              return Dismissible(
                                key: Key(
                                    controller.favoritesProductModel[index].productId),
                                background: Container(
                                  color: Colors.red,
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 33),
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                                onDismissed: (direction) {
                                  if (direction == DismissDirection.endToStart) {
                                    controller.removeProduct(controller
                                        .favoritesProductModel[index].productId);
                                  }
                                },
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  elevation: 4,
                                  child: Row(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(29)),
                                        width: 120,
                                        height: 120,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            controller
                                                .favoritesProductModel[index].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: controller
                                                  .favoritesProductModel[index].name,
                                              fontSize: 16,
                                            ),
                                            CustomText(
                                              text:
                                                  '\$${controller.favoritesProductModel[index].price.toString()}',
                                              color: primaryColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                            SizedBox(
                                              height: 16,
                                            ),
                                            Container(
                                              width: 95,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: Colors.grey.shade200,
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      GestureDetector(
                                                        child: Icon(
                                                          Icons.add,
                                                          color: Colors.black,
                                                          size: 20,
                                                        ),
                                                        onTap: () {
                                                          // controller
                                                          //     .increaseQuantity(
                                                          //         index);
                                                        },
                                                      ),
                                                      CustomText(
                                                        text: ('2'),
                                                        alignment: Alignment.center,
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                      Container(
                                                        // padding: EdgeInsets.only(bottom: 20),
                                                        child: GestureDetector(
                                                          child: Icon(
                                                            Icons.remove,
                                                            color: Colors.black,
                                                            size: 20,
                                                          ),
                                                          onTap: () {
                                                            // controller
                                                            //   ..decreaseQuantity(
                                                            //       index);
                                                          },
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            itemCount: controller.favoritesProductModel.length,
                          ),
                        ),
                      ),
                     
                    ],
                  ),
              
            
      ),
    );
  }
}
