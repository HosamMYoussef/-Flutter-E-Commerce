import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshopp/view/product_details_view.dart';
import 'package:path/path.dart';
import '../model/product_model.dart';
import '../constants.dart';
import '../widgets/custom_text.dart';

class CategoryProductsView extends StatelessWidget {
  final String categoryName;
  final List<ProductModel> products;

  CategoryProductsView({required this.categoryName, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
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
                    text: categoryName,
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
            child: Padding(
              padding: EdgeInsets.only(right: 16, left: 16, bottom: 24),
              child: GridView.builder(
                padding: const EdgeInsets.all(0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 15,
                  mainAxisExtent: 320,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          ProductDetailView(id: products[index].productId),
                        );
                      },
                      child: Container(
                        width: 164,
                        height: 300,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              height: 220,
                              width: 164,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                  products[index].image,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            CustomText(
                              text: products[index].name,
                              fontSize: 16,
                            ),
                            Row(children: [
                              RatingBar.readOnly(
                                filledIcon: Icons.star,
                                emptyIcon: Icons.star_border,
                                initialRating: (products[index].rating ==
                                            null ||
                                        products[index].reviews == null ||
                                        products[index].reviews!.length < 1 ||
                                        products[index].rating!.length < 1 ||
                                        products[index].reviews == '0' ||
                                        products[index].rating == '0')
                                    ? 0
                                    : double.parse(products[index].rating!) /
                                        int.parse(products[index].reviews!),

                                maxRating: 5,
                                size: 20,
                                // alignment: Alignment.center,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomText(
                                color: Colors.black45,
                                text: products[index].reviews!.isEmpty
                                    ? '(0)'
                                    : '(${products[index].reviews})',
                              )
                            ]),
                            CustomText(
                              text: products[index].description,
                              fontSize: 12,
                              color: Colors.grey,
                              maxLines: 1,
                            ),
                            CustomText(
                              text: '\$${products[index].price}',
                              fontSize: 16,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return OverflowBox(
                      maxHeight: 290 + 70,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            ProductDetailView(id: products[index].productId),
                          );
                        },
                        child: Container(
                           margin: EdgeInsets.only(top: 67),
                          width: 164,
                          height: 330,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.white,
                                ),
                                height: 205,
                                width: 164,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                    products[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              CustomText(
                                text: products[index].name,
                                fontSize: 16,
                              ),
                              Row(children: [
                                RatingBar.readOnly(
                                  filledIcon: Icons.star,
                                  emptyIcon: Icons.star_border,
                                  initialRating: (products[index].rating ==
                                              null ||
                                          products[index].reviews == null ||
                                          products[index].reviews!.length < 1 ||
                                          products[index].rating!.length < 1 ||
                                          products[index].reviews == '0' ||
                                          products[index].rating == '0')
                                      ? 0
                                      : double.parse(products[index].rating!) /
                                          int.parse(products[index].reviews!),

                                  maxRating: 5,
                                  size: 20,
                                  // alignment: Alignment.center,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                CustomText(
                                  color: Colors.black45,
                                  text: products[index].reviews!.isEmpty
                                      ? '(0)'
                                      : '(${products[index].reviews})',
                                )
                              ]),
                              CustomText(
                                text: products[index].description,
                                fontSize: 12,
                                color: Colors.grey,
                                maxLines: 1,
                              ),
                              CustomText(
                                text: '\$${products[index].price}',
                                fontSize: 16,
                                color: primaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
