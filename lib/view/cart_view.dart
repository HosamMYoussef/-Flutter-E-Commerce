import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/cart_view_model.dart';
import 'package:myshopp/view/Favorites_view.dart';
import 'package:myshopp/view/product_details_view.dart';
import 'package:myshopp/widgets/custom_button.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../core/viewmodel/checkoutview_model.dart';
import '../core/viewmodel/home_view_model.dart';
import 'checkout_view.dart';

class CartView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel());
    return GetBuilder<CartViewModel>(
      init: Get.put(CartViewModel()),
      builder: (controller) => Scaffold(
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
                  'Cart',
                  style: TextStyle(
                      fontSize: 26, color: Colors.white, fontFamily: 'Baumans'),
                )),
              ),
            ),
          ),
        ),
        body: controller.cartProductModel.length == 0
            ? Stack(
                children: [
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
                      color: const Color.fromRGBO(246, 246, 246, 1),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/empty.gif',
                              width: 350,
                              height: 350,
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            CustomText(
                              text: "Your Cart is empty ",
                              fontFamily: 'Amazon',
                              fontSize: 26,
                              alignment: Alignment.topCenter,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            CustomText(
                              color: Colors.black54,
                              text:
                                  "Be sure to fill your cart with something you like  ",
                              fontFamily: 'Amazon',
                              fontSize: 15,
                              alignment: Alignment.topCenter,
                            )
                          ],
                        )),
                  ),
                ],
              )
            : Stack(
                children: [
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
                      color: const Color.fromRGBO(246, 246, 246, 1),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                    ),
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 10, right: 16, left: 16),
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(
                            height: 14,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(
                                controller.cartProductModel[index].productId),
                            background: Container(
                              color: Colors.red,
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.only(right: 33),
                              child: const Icon(
                                Icons.delete_outline,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            onDismissed: (direction) {
                              if (direction == DismissDirection.endToStart) {
                                controller.removeProduct(controller
                                    .cartProductModel[index].productId);
                              }
                            },
                            child: GestureDetector(
                              onTap: () {
                                Get.to(ProductDetailView(
                                    id: controller
                                        .cartProductModel[index].productId));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 4,
                                child: Row(
                                  children: [
                                    GetBuilder<CartViewModel>(
                                      builder: (controller) => Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(29)),
                                        width: 120,
                                        height: 120,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            bottomLeft: Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            controller
                                                .cartProductModel[index].image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 15.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: 200,
                                            child: CustomText(
                                              text: controller
                                                  .cartProductModel[index].name,
                                              maxLines: 3,
                                              fontSize: 16,
                                            ),
                                          ),
                                          CustomText(
                                            text:
                                                '\$${controller.cartProductModel[index].price.toString()}',
                                            color: primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                            width: 120,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.white,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 40,
                                                      height: 32,
                                                      child: OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          controller
                                                              .increaseQuantity(
                                                                  index);
                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 20 / 2),
                                                      child: Text(
                                                        // if our item is less  then 10 then  it shows 01 02 like that
                                                        controller
                                                            .cartProductModel[
                                                                index]
                                                            .quantity
                                                            .toString()
                                                            .padLeft(2, "0"),
                                                        style: const TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 40,
                                                      height: 32,
                                                      child: OutlinedButton(
                                                        style: OutlinedButton
                                                            .styleFrom(
                                                          padding:
                                                              EdgeInsets.zero,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        13),
                                                          ),
                                                        ),
                                                        onPressed: () {
                                                          controller
                                                              .decreaseQuantity(
                                                                  index);
                                                        },
                                                        child: const Icon(
                                                          Icons.remove,
                                                          size: 20,
                                                          color: Colors.black,
                                                        ),
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
                            ),
                          );
                        },
                        itemCount: controller.cartProductModel.length,
                      ),
                    ),
                  ),
                  Material(
                    elevation: 12,
                    child: Container(
                      color: Colors.grey.shade50,
                      padding:
                          const EdgeInsets.only(top: 10, left: 30, right: 30
                              //vertical: 17

                              ),
                      height: 64,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 0.0),
                                child: CustomText(
                                  text: 'TOTAL',
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              GetBuilder<CartViewModel>(
                                init: Get.find(),
                                builder: (controller) => CustomText(
                                  text: '\$${controller.totalPrice}',
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          // one dev to role the all

                          SizedBox(
                            height: 50,
                            width: 200,
                            child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18)),
                              color: primaryColor,
                              onPressed: () {
                                Get.to(CheckoutView());
                              },
                              child: Text(
                                "CheckOut".toUpperCase(),
                                style: const TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
                  ),
                ],
              ),
      ),
    );
  }
}
