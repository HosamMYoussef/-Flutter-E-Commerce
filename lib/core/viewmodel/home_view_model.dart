import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/Category_model.dart';
import 'package:myshopp/model/user_model.dart';

import '../../model/comment_model.dart';
import '../../model/product_model.dart';
import '../services/database/firestore_Add_products.dart';
import '../services/database/firestore_comment.dart';
import '../services/home_Services.dart';

class HomeViewModel extends GetxController {
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];

  List<UserModel> _users = [];
  List<CommentModel> _comments = [];

  List<CommentModel> get comments => _comments;
  List<CategoryModel> get categories => _categories;

  List<UserModel> get users => _users;

  List<ProductModel> get products => _products;

  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  @override
  void onInit() {
    super.onInit();
    _getCategoriesFromFireStore();
    _getProductsFromFireStore();
    _getusersFromFireStore();
    _getCommentsFromFireStore();
  }

  _getCommentsFromFireStore() async {
    _loading.value = true;
    List<QueryDocumentSnapshot> commentsSnapshot =
        await FirestoreHome().getCommentsFromFirestore();
    commentsSnapshot.forEach((comment) {
      _comments
          .add(CommentModel.fromJson(comment.data() as Map<String, dynamic>));
    });
    _loading.value = false;
    update();
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

  _getusersFromFireStore() async {
    _loading.value = true;
    List<QueryDocumentSnapshot> usersSnapshot =
        await FirestoreHome().getusersFromFirestore();
    usersSnapshot.forEach((user) {
      _users.add(UserModel.fromJson(user.data() as Map<String, dynamic>));
    });
    _loading.value = false;
    update();
  }

  deleteProductsFromFireStore(String id) async {
    FirestoreSell().deleteData(id);

    products.removeWhere((prod) => prod.productId == id);
    update();
  }
}
