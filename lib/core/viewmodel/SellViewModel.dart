import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:myshopp/constants.dart';
import 'package:myshopp/core/services/database/firestore_Add_products.dart';
import 'package:myshopp/core/viewmodel/home_view_model.dart';
import 'package:myshopp/core/viewmodel/profile_viewmodel.dart';
import 'package:myshopp/model/product_model.dart';

import '../../helper/local_storage_data.dart';
import '../../model/checkout_model.dart';
import '../services/database/firestoreCheckOut.dart';
import 'cart_view_model.dart';

class SellModel extends GetxController {
  late String? name,
      image = 'aa',
      description,
      sized,
      price,
      productId = '1',
      category;
  late String? detalis;
  late String? sellerId;
  late String? color;

  late String? detail = "aaa";
  late String? det;
  List<ProductModel> _sells = [];

  List<ProductModel> get sells => _sells;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @override
  void onInit() {
    super.onInit();
    _getCheckoutsFromFireStore();
  }

  _getCheckoutsFromFireStore() async {
    _isLoading = true;
    _sells = [];
    List<QueryDocumentSnapshot> _checkoutsSnapshot =
        await FirestoreSell().getOrdersFromFirestore();
    _checkoutsSnapshot.forEach((order) {
      _sells.add(ProductModel.fromJson(order.data() as Map<String, dynamic>));
    });
    _isLoading = false;
    update();
  }

  addProductsToFireStore() async {
    Get.put(HomeViewModel());

    Get.find<HomeViewModel>().products.add(ProductModel(
          category: category!,
          description: description!,
          det: det!,
          image: image!,
          name: name!,
          price: price!,
          productId: productId!,
          sized: sized!,
          color: Colors.red,
          sellerId: sellerId!,
          rating: '0',
          reviews: '0',
        ));
    await FirestoreSell().addOrderToFirestore(ProductModel(
      category: category!,
      description: description!,
      det: det!,
      image: image!,
      name: name!,
      price: price!,
      productId: productId!,
      sized: sized!,
      color: Colors.black,
      sellerId: sellerId!,
      rating: '0',
      reviews: '0',
    ));
    Get.back();
  }
}
