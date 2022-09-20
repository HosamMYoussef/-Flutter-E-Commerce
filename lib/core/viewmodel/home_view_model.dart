import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/Category_model.dart';

import '../../model/product_model.dart';
import '../services/home_Services.dart';



class HomeViewModel extends GetxController {
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];

  List<CategoryModel> get categories => _categories;

  List<ProductModel> get products => _products;


  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  @override
  void onInit() {
    super.onInit();
    _getCategoriesFromFireStore();
    _getProductsFromFireStore();
  }

  _getCategoriesFromFireStore() async {
    _loading.value = true;
    List<QueryDocumentSnapshot> categoriesSnapshot =
        await FirestoreHome().getCategoriesFromFirestore();
    categoriesSnapshot.forEach((category) {
      _categories
          .add(CategoryModel.fromJson(category.data() as Map<String, dynamic>));
    });
    _loading.value = false;
    update();
  }

  _getProductsFromFireStore() async {
    _loading.value = true;
    List<QueryDocumentSnapshot> productsSnapshot =
        await FirestoreHome().getProductsFromFirestore();
    productsSnapshot.forEach((product) {
      _products
          .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
    });
    _loading.value = false;
    update();
  }
}
