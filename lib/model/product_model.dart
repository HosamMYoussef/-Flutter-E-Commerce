import 'package:flutter/material.dart';

import '../helper/hexColor_extension.dart';

class ProductModel {
  late String name, image, description, sized, price, productId, category;
  late String detalis = 'aa';
  late String detail="aaa";
  late String det='aa';
  late Color color;

  ProductModel({
    required this.name,
    required this.image,
    required this.description,
    required this.sized,
    required this.price,
    required this.productId,
    required this.category,
    required this.color,
    required this.detalis,
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    productId = map['productId'];
    image = map['image'];
    description = map['description'];
    price = map['price'];
    category = map['category'];
  //  detail = map['detail'];
    det = map['det'];
    // detalis = map['detalis'];

    color = HexColor.fromHex(map['color']);
    sized = map['sized'];
  }

  toJson() {
    return {
      'name': name,
      'image': image,
      'category': category,
      'description': description,
      'color': color.toString(),
      'price': price,
      'sized': sized,
      'detail': detail,
      'det': det,
      'productId': productId,
    };
  }
}
