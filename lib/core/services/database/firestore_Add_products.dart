import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:myshopp/model/auction_model.dart';
import 'package:myshopp/model/product_model.dart';

import '../../../model/checkout_model.dart';

class FirestoreSell {
  late final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('Products');

      
  late final CollectionReference _auctionCollection =
      FirebaseFirestore.instance.collection('auctions');

  Future<List<QueryDocumentSnapshot>> getOrdersFromFirestore() async {
    var _orders =
        await _ordersCollection.orderBy('date', descending: true).get();
    return _orders.docs;
  }

  addOrderToFirestore(ProductModel productModel) async {
    var docRef = await _ordersCollection.add(productModel.toJson());
    var documentId = docRef.id; //? <-- Document ID
    print(documentId);

    _ordersCollection.doc(documentId).update({'productId': documentId});
  }

  addAuctionToFirestore(AuctionModel productModel) async {
    var docRef = await _auctionCollection.add(productModel.toJson());
    var documentId = docRef.id; //? <-- Document ID
    print(documentId);

    _auctionCollection.doc(documentId).update({'productId': documentId});
  }
  // <-- Document ID

  // delete(ProductModel productModel) async {
  //   await _ordersCollection.doc().delete(productModel.toJson());
  // }

  // //

  deleteData(String iD) async {
    await FirebaseFirestore.instance
        .collection("Products")
        .where("productId", isEqualTo: iD)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        FirebaseFirestore.instance
            .collection("Products")
            .doc(element.id)
            .delete()
            .then((value) {
          print("Success!");
        });
      });
    });
  }
}
