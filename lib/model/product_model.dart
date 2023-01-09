import 'package:flutter/material.dart';

import '../helper/hexColor_extension.dart';

class ProductModel {
  late String name, image, description, sized, price, productId, category;

  late String detail = "aaa";
  late String? sellerId = "";
  late String? reviews = "";
  late String? quantity = "";
  late String? rating = "";
  late String det = 'aa';
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
    required this.det,
    this.sellerId = '',
    this.rating = '',
    this.reviews = '',
    this.quantity = '',
  });

  ProductModel.fromJson(Map<dynamic, dynamic> map) {
    name = map['name'];
    productId = map['productId'];
    image = map['image'];
    description = map['description'];
    price = map['price'];
    category = map['category'];
    rating = map['rating'];
    det = map['det'];
    sellerId = map['sellerId'];
    reviews = map['reviews'];
    quantity = map['quantity'];

    // color = HexColor.fromHex(map['color']);
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
      'rating': rating,
      'reviews': reviews,
      'sellerId': sellerId,
      'quantity': quantity,
      'det': det,
      'productId': productId,
    };
  }
}
