import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:myshopp/model/product_model.dart';

import '../../../model/checkout_model.dart';

class FirestoreSell {
  late final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('products');

  Future<List<QueryDocumentSnapshot>> getOrdersFromFirestore() async {
    var _orders =
        await _ordersCollection.orderBy('date', descending: true).get();
    return _orders.docs;
  }

  addOrderToFirestore(ProductModel productModel) async {
    var docRef = await _ordersCollection.add(productModel.toJson());
    var documentId = docRef.id; //? <-- Document ID
    print(documentId);

    _ordersCollection.doc(documentId).update({'productId':documentId });
  }
  // <-- Document ID

  // delete(ProductModel productModel) async {
  //   await _ordersCollection.doc().delete(productModel.toJson());
  // }

  // //

  // // Future deleteData(String id) async {
  // //   try {
  // //     await FirebaseFirestore.instance
  // //         .collection("products")
  // //         .doc(_ordersCollection.doc().id)
  // //         .delete();
  // //   } catch (e) {
  // //     return false;
  // //   }
  // // }
}
