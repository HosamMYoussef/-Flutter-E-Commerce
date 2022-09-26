import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/cart_view_model.dart';
import 'package:myshopp/model/cart_product_model.dart';
import 'package:myshopp/model/product_model.dart';
import 'package:myshopp/view/Favorites_view.dart';
import 'package:myshopp/view/checkout_view.dart';
import 'package:myshopp/widgets/custom_button.dart';
import 'package:myshopp/widgets/custom_text.dart';

import '../core/viewmodel/Favorites_ view_model.dart';
import '../core/viewmodel/checkoutview_model.dart';
import '../model/Favorites_model.dart';

class ProductDetailView extends StatelessWidget {
  ProductModel productModel;

  ProductDetailView({required this.productModel});

  @override
  Widget build(BuildContext context) {
    Get.put(CheckoutViewModel());
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 196,
                        width: double.infinity,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            productModel.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // GetBuilder<FavoritesviewModel>(
                      //     init: FavoritesviewModel(),
                      //     builder: ((controller) => Padding(
                      //           padding:
                      //               const EdgeInsets.only(top: 130, left: 320),
                      //           child: Container(
                      //             child: IconButton(
                      //               onPressed: () {
                      //                 controller
                      //                     .addProduct(FavortiesProdcutModel(
                      //                   name: productModel.name,
                      //                   image: productModel.image,
                      //                   price: productModel.price,
                      //                   productId: productModel.productId,
                      //                   // category: productModel.category,
                      //                 ));
                      //               },
                      //               // backgroundColor: primaryColor,

                      //               icon: Icon(
                      //                 LineIcons.heart,
                      //                 size: 40,
                      //               ),
                      //             ),
                      //           ),
                      //         ))
                      // ),
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomText(
                              text: productModel.name,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top:10.0,right: 20),
                              child: Column(
                                children: [
                                  CustomText(
                                    text: 'Price',
                                    fontSize: 16,
                                    color: Colors.grey,
                                  ),
                                  CustomText(
                                    text: '\$${productModel.price}',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedShapeInfo(
                              title: 'Size',
                              content: CustomText(
                                text: productModel.sized,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                alignment: Alignment.center,
                              ),
                            ),
                            RoundedShapeInfo(
                              title: 'Color',
                              content: Container(
                                height: 22,
                                width: 22,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                  color: productModel.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 33,
                        ),
                        CustomText(
                          text: 'Details',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        CustomText(
                          text: productModel.det,
                          fontSize: 14,
                          height: 2,
                          maxLines: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Material(
            elevation: 12,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 50,
                    width: 58,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: primaryColor,
                      ),
                    ),
                    child: GetBuilder<CartViewModel>(
                      init: CartViewModel(),
                      builder: ((controller) => IconButton(
                            icon: SvgPicture.asset(
                              "assets/images/add_to_cart.svg",
                              color: primaryColor,
                            ),
                            onPressed: () {
                              controller.addProduct(CartProductModel(
                                name: productModel.name,
                                image: productModel.image,
                                price: productModel.price,
                                productId: productModel.productId,
                                // category: productModel.category,
                                quantity: 1,
                              ));
                            },
                          )),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: GetBuilder<CartViewModel>(
                        init: Get.put(CartViewModel()),
                        builder: (controller) => FlatButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          color: primaryColor,
                          onPressed: () {
                            controller.addProduct(CartProductModel(
                              name: productModel.name,
                              image: productModel.image,
                              price: productModel.price,
                              productId: productModel.productId,
                              // category: productModel.category,
                              quantity: 1,
                            ));
                            Get.to(CheckoutView());
                          },
                          child: Text(
                            "Buy  Now".toUpperCase(),
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // child: Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         CustomText(
              //           text: 'PRICE',
              //           fontSize: 12,
              //           color: Colors.grey,
              //         ),
              //         CustomText(
              //           text: '\$${productModel.price}',
              //           fontSize: 18,
              //           fontWeight: FontWeight.bold,
              //           color: primaryColor,
              //         ),
              //       ],
              //     ),
              //     GetBuilder<CartViewModel>(
              //       init: CartViewModel(),
              //       builder: ((controller) => Container(

              //             decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(40)),
              //             //padding: EdgeInsets.all(27),

              //             width: 146,
              //             height: 50,
              //             child: CustomButton(
              //               text: 'ADD',
              //               onPressed: () {
              //                 print(productModel.name);
              //                 controller.addProduct(CartProductModel(
              //                   name: productModel.name,
              //                   image: productModel.image,
              //                   price: productModel.price,
              //                   productId: productModel.productId,
              //                   // category: productModel.category,
              //                   quantity: 1,
              //                 ));
              //               },
              //             ),
              //           )),
              //     )

              //   ],
              // ),
            ),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<FavoritesviewModel>(
          init: FavoritesviewModel(),
          builder: ((controller) => Padding(
                padding: const EdgeInsets.only(bottom: 80, right: 0),
                child: FloatingActionButton(
                  onPressed: () {
                    controller.addProduct(FavortiesProdcutModel(
                      name: productModel.name,
                      image: productModel.image,
                      price: productModel.price,
                      productId: productModel.productId,
                      // category: productModel.category,
                    ));
                  },
                  backgroundColor: primaryColor,
                  child: Icon(LineIcons.heart),
                ),
              ))),
    );
  }
}

class RoundedShapeInfo extends StatelessWidget {
  final String title;
  final Widget content;

  const RoundedShapeInfo({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              text: title,
              fontSize: 14,
              alignment: Alignment.center,
            ),
            content,
          ],
        ),
      ),
    );
  }
}
