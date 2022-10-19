import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../model/cart_product_model.dart';
import '../services/database/cart_database.dart';

class CartViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<CartProductModel> _cartProductModel = [];

  List<CartProductModel> get cartProductModel => _cartProductModel;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  CartViewModel() {
    getCartProducts();
  }

  getCartProducts() async {
    _cartProductModel = await LocalDatabaseCart.db.getAllProdcuts();
    getTotalPrice();
    update();
  }

  addProduct(CartProductModel cartProductModel) async {
    bool _isExist = false;
    _cartProductModel.forEach((element) {
      if (element.productId == cartProductModel.productId) {
        _isExist = true;
      }
    });
    if (!_isExist) {
      await LocalDatabaseCart.db.insert(cartProductModel);
      getCartProducts();
    }
  }

  void getTotalPrice() {
    _totalPrice = 0;
    _cartProductModel.forEach((cartProduct) {
      _totalPrice += (double.parse(cartProduct.price) * cartProduct.quantity);
      print(_totalPrice);
    });
  }

  increaseQuantity(int index) async {
    _cartProductModel[index].quantity++;
    getTotalPrice();
    await LocalDatabaseCart.db.update(_cartProductModel[index]);
    update();
  }
  decreaseQuantity(int index) async {
    if (_cartProductModel[index].quantity != 1) {
      _cartProductModel[index].quantity--;
      getTotalPrice();
      await LocalDatabaseCart.db.update(_cartProductModel[index]);
      update();
    }
  }
    removeProduct(String productId) async {
    await LocalDatabaseCart.db.deleteProduct(productId);
    getCartProducts();
  }
    removeAllProducts() async {
    await LocalDatabaseCart.db.deleteAllProducts();
    getCartProducts();
  }
}
