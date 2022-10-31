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
        preferredSize: const Size.fromHeight(60.0), // here the desired height
        child: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0),
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
                end: Alignment. bottomRight,
                colors: [
                  Color.fromRGBO(131, 217, 226, 1),
                   Color.fromRGBO(162, 230, 209, 1),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 26, left: 50, right: 16, bottom: 3),
              child: Card(shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(15.0),
  ),elevation: 4, child: _searchTextFormField()),
            ),
          ),
        ),
      ),
      body: Column(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: Colors.white,
                              ),
                              height: 240,
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
