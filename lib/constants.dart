import 'package:flutter/material.dart';

final String tableCartProduct = 'cartProducts';
final String columnName = 'name';
final String columnImage = 'image';
final String columnQuantity = 'quantity';
final String columnPrice = 'price';
final String columnproductId = 'productId';

const primaryColor = Color.fromRGBO(0, 197, 105, 1);
// const primaryColor = Color.fromRGBO(60, 183, 105, 1);

const kTileHeight = 50.0;
const inProgressColor = Colors.black87;
const todoColor = Color(0xffd1d2d7);

enum Pages {
  DeliveryTime,
  AddAddress,
  Summary,
}