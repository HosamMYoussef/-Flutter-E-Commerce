import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/viewmodel/home_view_model.dart';
import '../model/product_model.dart';

import '../constants.dart';
import '../widgets/custom_text.dart';
import 'product_details_view.dart';

class SearchView extends StatefulWidget {
  final String? searchValue;

  SearchView(this.searchValue);

  @override
  _SearchViewState createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String? _searchValue;

  @override
  void initState() {
    print(_searchValue);
    _searchValue = widget.searchValue!.toLowerCase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> _searchProducts = _searchValue == ''
        ? []
        : Get.find<HomeViewModel>()
            .products
            .where(
                (product) => product.name.toLowerCase().contains(_searchValue!))
            .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0), // here the desired height
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 0.0),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_sharp,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                Get.back();
              },
            ),
          ),
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
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 26, left: 50, right: 16, bottom: 3),
              child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 4,
                  child: _searchTextFormField()),
            ),
          ),
        ),
      ),
      body: _searchProducts.length < 1
          ? Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                Image.asset(
                  'assets/images/empty.png',
                  fit: BoxFit.cover,
                  height: 300,
                  width: 400,
                ),
                CustomText(
                  text: "We couldn't find what you're looking for",
                  fontFamily: 'Cairo',
                  fontSize: 18,
                  color: Colors.black87,
                  alignment: Alignment.topCenter,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 3,
                ),
                CustomText(
                  color: Colors.black54,
                  text: "Why not try an alternative?  ",
                  fontFamily: 'Amazon',
                  fontSize: 17,
                  alignment: Alignment.topCenter,
                )
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: 24,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 16, left: 16, bottom: 24),
                    child: GetBuilder<HomeViewModel>(
                      init: Get.find<HomeViewModel>(),
                      builder: (controller) => GridView.builder(
                        padding: const EdgeInsets.all(0),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 30,
                          mainAxisExtent: 300,
                        ),
                        itemCount: _searchProducts.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                ProductDetailView(
                                    id: _searchProducts[index].productId),
                              );
                            },
                            child: Container(
                              width: 164,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                      borderRadius: BorderRadius.circular(25),
                                      child: Image.network(
                                        _searchProducts[index].image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  CustomText(
                                    text: _searchProducts[index].name,
                                    fontSize: 16,
                                  ),
                                  Row(children: [
                                    RatingBar.readOnly(
                                      filledIcon: Icons.star,
                                      emptyIcon: Icons.star_border,
                                      initialRating: (_searchProducts[index]
                                                      .rating ==
                                                  null ||
                                              _searchProducts[index].reviews ==
                                                  null ||
                                              _searchProducts[index]
                                                      .reviews!
                                                      .length <
                                                  1 ||
                                              _searchProducts[index]
                                                      .rating!
                                                      .length <
                                                  1 ||
                                              _searchProducts[index].reviews ==
                                                  '0' ||
                                              _searchProducts[index].rating ==
                                                  '0')
                                          ? 0
                                          : double.parse(_searchProducts[index]
                                                  .rating!) /
                                              int.parse(_searchProducts[index]
                                                  .reviews!),

                                      maxRating: 5,
                                      size: 20,
                                      // alignment: Alignment.center,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    CustomText(
                                      color: Colors.black45,
                                      text: _searchProducts[index]
                                              .reviews!
                                              .isEmpty
                                          ? '(0)'
                                          : '(${_searchProducts[index].reviews})',
                                    )
                                  ]),
                                  CustomText(
                                    text: _searchProducts[index].description,
                                    fontSize: 12,
                                    color: Colors.grey,
                                    maxLines: 1,
                                  ),
                                  CustomText(
                                    text: '\$${_searchProducts[index].price}',
                                    fontSize: 16,
                                    color: primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _searchTextFormField() {
    return Container(
      height: 49,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          hintText: "Search Shopify",
          border: InputBorder.none,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.black,
          ),
        ),
        initialValue: _searchValue,
        onFieldSubmitted: (value) {
          setState(() {
            _searchValue = value.toLowerCase();
          });
        },
      ),
    );
  }
}
// one dev to role the all
