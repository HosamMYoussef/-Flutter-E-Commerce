import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/view/auth/login_screen.dart';
import 'package:myshopp/view/cart_view.dart';
import 'package:myshopp/view/search_view.dart';
import 'package:path/path.dart';

import '../constants.dart';
import '../constants.dart';
import '../core/viewmodel/control_view_model.dart';
import '../core/viewmodel/home_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import 'category_products_view.dart';
import 'product_details_view.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Get.put(HomeViewModel());
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => controller.loading.value
          ? Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor:  const Color.fromRGBO(246, 246, 246, 1),

              body: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Padding(
                      padding:  EdgeInsets.only(top: 20.0),
                      child:SizedBox(),
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
                      padding:
                          EdgeInsets.only(top: 29, left: 16, right: 16, bottom: 14),
                      child: Column(
                        children: [
                          _searchTextFormField(),
                          SizedBox(
                            height: 40,
                          ),
                          CustomText(
                            text: 'Categories',
                            fontFamily: 'Baumans',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
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
                              CustomText(
                                text: "Best Selling ",
                                fontFamily: 'Baumans',
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
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
                          SizedBox(
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(45),
        color: Colors.grey.shade200,
      ),
      child: TextFormField(
        decoration:const InputDecoration(
          hintText: "What are you looking for?",
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black54,
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
                        color: Colors.white,
                      ),
                      height: 240,
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
                    CustomText(
                      text: controller.products[index].name,
                      fontSize: 16,
                    ),
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
}
