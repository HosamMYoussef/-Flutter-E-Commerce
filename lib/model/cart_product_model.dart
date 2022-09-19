import 'package:flutter/material.dart';

import '../helper/hexColor_extension.dart';

class CartProductModel {
  late String name, image, productId, price;
  late int quantity;

  CartProductModel({
    required this.name,
    required this.image,
    required this.productId,
    required this.price,
    this.quantity = 1,
  });

  CartProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    image = map['image'];

    price = map['price'];
    productId = map['productId'];
    //  detail = map['detail'];
    // detalis = map['detalis'];

    quantity = (map['quantity']);
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'productId': productId,

      'quantity': quantity.toString(),
      'price': price,

      // 'detalis': detalis,
    };
  }
}
