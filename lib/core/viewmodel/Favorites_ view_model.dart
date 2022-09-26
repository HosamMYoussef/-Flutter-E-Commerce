import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/Favorites_model.dart';
import '../../model/Favorites_model.dart';
import '../services/database/favorites_database.dart';

class FavoritesviewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;

  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<FavortiesProdcutModel> _favoritesProductModel = [];

  List<FavortiesProdcutModel> get favoritesProductModel => _favoritesProductModel;

  double _totalPrice = 0;

  double get totalPrice => _totalPrice;

  FavoritesviewModel() {
    getFavoritesProducts();
  }

  getFavoritesProducts() async {
    _favoritesProductModel = await LocalDatabaseFavorites.db.getAllProdcuts();
    update();
  }

  addProduct(FavortiesProdcutModel favoritesProductModel) async {
    bool _isExist = false;
    _favoritesProductModel.forEach((element) {
      if (element.productId == favoritesProductModel.productId) {
        _isExist = true;
      }
    });
    if (!_isExist) {
      await LocalDatabaseFavorites.db.insert(favoritesProductModel);
      getFavoritesProducts();
    }
  }

  void getTotalPrice() {
    _totalPrice = 0;
    _favoritesProductModel.forEach((cartProduct) {
      _totalPrice += (double.parse(cartProduct.price) * cartProduct.quantity);
      print(_totalPrice);
    });
  }

 
    removeProduct(String productId) async {
    await LocalDatabaseFavorites.db.deleteProduct(productId);
    getFavoritesProducts();
  }
    removeAllProducts() async {
    await LocalDatabaseFavorites.db.deleteAllProducts();
    getFavoritesProducts();
  }
}
