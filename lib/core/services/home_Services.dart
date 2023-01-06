import 'package:cloud_firestore/cloud_firestore.dart';

import '../../model/bid_model.dart';
import '../../model/comment_model.dart';

class FirestoreHome {
  final CollectionReference _categoriesCollection =
      FirebaseFirestore.instance.collection('Categories');

  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('Products');

  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _commentCollection =
      FirebaseFirestore.instance.collection('comments');
  final CollectionReference _bidsCollection =
      FirebaseFirestore.instance.collection('Bid');
  final CollectionReference _auctionsCollection =
      FirebaseFirestore.instance.collection('auctions');

  Future<List<QueryDocumentSnapshot>> getCategoriesFromFirestore() async {
    var categories = await _categoriesCollection.get();
    return categories.docs;
  }

  // Future<List<QueryDocumentSnapshot>> getusersFromFirestore() async {
  //   var users= await _usersCollection.get();
  //   return users.docs;
  // }

  Future<List<QueryDocumentSnapshot>> getProductsFromFirestore() async {
    var products = await _productsCollection.get();
    return products.docs;
  }

  Future<List<QueryDocumentSnapshot>> getusersFromFirestore() async {
    var products = await _usersCollection.get();
    return products.docs;
  }Future<List<QueryDocumentSnapshot>> getbidsFromFirestore() async {
    var products = await _bidsCollection.get();
    return products.docs;
  }

  Future<List<QueryDocumentSnapshot>> getCommentsFromFirestore() async {
    var products =
        await _commentCollection.orderBy('date', descending: true).get();
    return products.docs;
  }Future<List<QueryDocumentSnapshot>> getAuctionsFromFireStore() async {
    var auctions =
        await _auctionsCollection.get();
    return auctions.docs;
  }

  addCommentToFirestore(CommentModel commentModel) async {
    await _commentCollection.doc().set(commentModel.toJson());
  } 
  addBidToFirestore(BidModel bidModel) async {
    await _bidsCollection.doc().set(bidModel.toJson());
  }


  // updateReview(String id, String rating, String reviews) async {
  //   await FirebaseFirestore.instance.collection("Products").doc(id).update({
  //     "reviews": reviews,
  //     "rating": rating,
  //   });
  // }
}
