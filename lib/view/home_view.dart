// import 'dart:html';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:myshopp/view/review_view.dart';
import 'package:myshopp/view/search_view.dart';
import 'package:myshopp/view/testtt.dart';

import '../constants.dart';
import '../core/viewmodel/cart_view_model.dart';
import '../core/viewmodel/home_view_model.dart';
import '../widgets/custom_text.dart';
import '../widgets/speach.dart';
import 'category_products_view.dart';
import 'product_details_view.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String text = 'Press the button and start speaking';
  // one dev to role the all

  bool isListening = false;
  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => controller.isloading
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 30.0),
                            child: SizedBox(
                              width: 20,
                            ),
                          ),
                          const Text(
                            'Shopify',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Baumans',
                              fontSize: 26,
                            ),
                          ),
                          Container(
                            width: 30,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          top: 29, left: 16, right: 16, bottom: 14),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(45),
                              color: Colors.grey.shade200,
                            ),
                            child: Row(children: [
                              _searchTextFormField(),
                              AvatarGlow(
                                animate: isListening,
                                endRadius: 25,
                                glowColor: primaryColor,
                                child: IconButton(
                                  icon: Icon(
                                      isListening ? Icons.mic : Icons.mic_none,
                                      size: 30),
                                  onPressed: toggleRecording,
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          GestureDetector(
                            onTap: (() {
                              Get.to(Test());
                            }),
                            child: CustomText(
                              text: 'Categories',
                              fontFamily: 'Baumans',
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          _listViewCategory(),
                          SizedBox(
                            height: 25,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  print(Get.find<CartViewModel>()
                                      .cartProductModel
                                      .length);
                                },
                                child: CustomText(
                                  text: "Best Selling ",
                                  fontFamily: 'Baumans',
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(CategoryProductsView(
                                      categoryName: 'Best Selling',
                                      products: controller.products));
                                },
                                child: CustomText(
                                  text: "See all ",
                                  fontSize: 16,
                                  color: primaryColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          _listViewProducts(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _searchTextFormField() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.772,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        // color: Colors.grey.shade200,
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintStyle: TextStyle(color: Colors.black87),
          hintText: "What are you looking for?",
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black87,
          ),
        ),
        onFieldSubmitted: (value) {
          Get.to(SearchView(value));
        },
      ),
    );
  }

  Widget _listViewCategory() {
    return GetBuilder<HomeViewModel>(
      builder: ((controller) => Container(
            height: 100,
            child: ListView.separated(
              itemCount: controller.categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(CategoryProductsView(
                      categoryName: controller.categories[index].name,
                      products: controller.products
                          .where((product) =>
                              product.category ==
                              controller.categories[index].name.toLowerCase())
                          .toList(),
                    ));
                  },
                  child: Column(
                    children: [
                      Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white),
                          height: 60,
                          width: 60,
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Image.network(
                                controller.categories[index].image),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      CustomText(
                        text: controller.categories[index].name,
                        fontSize: 12,
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                width: 20,
              ),
            ),
          )),
    );
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
      builder: (controller) => Container(
        height: 320,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: controller.products.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (context) {
                //   return ProductDetailView(
                //       productModel: controller.products[index]);
                // },),);

                Get.to(ProductDetailView(
                    id: controller.products[index].productId));
              },
              child: Container(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.transparent,
                      ),
                      height: 220,
                      width: 164,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          controller.products[index].image,
                          fit: BoxFit.cover,
                          // fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    CustomText(
                      text: controller.products[index].name,
                      fontSize: 16,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(children: [
                      RatingBar.readOnly(
                        filledIcon: Icons.star,
                        emptyIcon: Icons.star_border,
                        initialRating: (controller.products[index].rating ==
                                    null ||
                                controller.products[index].reviews == null ||
                                controller.products[index].reviews!.length <
                                    1 ||
                                controller.products[index].rating!.length < 1 ||
                                controller.products[index].reviews == '0' ||
                                controller.products[index].rating == '0')
                            ? 0
                            : double.parse(controller.products[index].rating!) /
                                int.parse(controller.products[index].reviews!),

                        maxRating: 5,
                        size: 20,
                        // alignment: Alignment.center,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      CustomText(
                        color: Colors.black45,
                        text: controller.products[index].reviews!.isEmpty
                            ? '(0)'
                            : '(${controller.products[index].reviews})',
                      )
                    ]),
                    CustomText(
                      text: controller.products[index].description,
                      fontSize: 12,
                      color: Colors.grey,
                      maxLines: 1,
                    ),
                    CustomText(
                      fontWeight: FontWeight.bold,
                      text: '\$${controller.products[index].price}',
                      fontSize: 16,
                      color: primaryColor,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 15,
            );
          },
        ),
      ),
    );
  }

  Future toggleRecording() => SpeechApi.toggleRecording(
        onResult: (text) => setState(() {
          this.text = text;
          print(text);
        }),
        onListening: (isListening) {
          setState(() => this.isListening = isListening);

          if (!isListening) {
            Future.delayed(Duration(milliseconds: 500), () {
              Get.to(SearchView(text));
            });
          }
        },
      );
}
