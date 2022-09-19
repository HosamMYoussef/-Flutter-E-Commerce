import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/viewmodel/cart_view_model.dart';
import 'package:myshopp/model/cart_product_model.dart';
import 'package:myshopp/model/product_model.dart';
import 'package:myshopp/widgets/custom_button.dart';
import 'package:myshopp/widgets/custom_text.dart';

class ProductDetailView extends StatelessWidget {
  ProductModel productModel;

  ProductDetailView({required this.productModel});

  @override
  Widget build(BuildContext context) {
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
                        child: Image.network(
                          productModel.image,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                        CustomText(
                          text: productModel.name,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        SizedBox(
                          height: 25,
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
              padding: EdgeInsets.symmetric(vertical: 17, horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        text: 'PRICE',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                      CustomText(
                        text: '\$${productModel.price}',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ],
                  ),
                  GetBuilder<CartViewModel>(
                    init: CartViewModel(),
                    builder: ((controller) => Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
                          //padding: EdgeInsets.all(27),

                          width: 146,
                          height: 50,
                          child: CustomButton(
                            text: 'ADD',
                            onPressed: () {
                              controller.addProduct(CartProductModel(
                                  name: productModel.name,
                                  image: productModel.image,
                                  price: productModel.price,
                                  productId: productModel.productId,
                                 // category: productModel.category,
                                  quantity:1,));
                            },
                          ),
                        )),
                  )
                  // GetBuilder<CartViewModel>(
                  //   builder: (controller) => Container(
                  //     width: 146.w,
                  //     child: CustomButton('ADD', () {
                  //       controller.addProduct(
                  //         CartModel(
                  //           name: _productModel.name,
                  //           image: _productModel.image,
                  //           price: _productModel.price,
                  //           productId: _productModel.productId,
                  //         ),
                  //       );
                  //     }),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
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
