import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/Category_model.dart';
import 'package:myshopp/model/bid_model.dart';
import 'package:myshopp/model/user_model.dart';
import 'dart:convert';
import '../../model/auction_model.dart';
import '../../model/comment_model.dart';
import 'package:http/http.dart' as http;
import '../../model/product_model.dart';
import '../services/database/firestore_Add_products.dart';
import '../services/home_Services.dart';

class HomeViewModel extends GetxController {
  List<CategoryModel> _categories = [];
  List<ProductModel> _products = [];

  List<UserModel> _users = [];
  List<BidModel> _bids = [];
  List<CommentModel> _comments = [];
  List<AuctionModel> _auctions = [];

  List<CommentModel> get comments => _comments;
  List<AuctionModel> get auctions => _auctions;
  List<CategoryModel> get categories => _categories;
  List<BidModel> get bids => _bids;

  List<UserModel> get users => _users;

  List<ProductModel> get products => _products;

  ValueNotifier<bool> get loading => _loading;
  var _isloading = false;
  bool get isloading => _isloading;
  ValueNotifier<bool> _loading = ValueNotifier(false);

  @override
  void onInit() {
    super.onInit();
    _getCategoriesFromFireStore();
    getProductsFromFireStore();
    _getusersFromFireStore();
    _getCommentsFromFireStore();
    _getAuctionsFromFireStore();
    _getbidsFromFireStore();
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

  _getAuctionsFromFireStore() async {
    _loading.value = true;
    List<QueryDocumentSnapshot> auctionsSnapshot =
        await FirestoreHome().getAuctionsFromFireStore();
    auctionsSnapshot.forEach((auction) {
      _auctions
          .add(AuctionModel.fromJson(auction.data() as Map<String, dynamic>));
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

  Future getProductsFromFireStore() async {
    _loading.value = true;
    var load = false;
    _isloading = false;
    List<QueryDocumentSnapshot> productsSnapshot =
        await FirestoreHome().getProductsFromFirestore();
    productsSnapshot.forEach((product) {
      _products
          .add(ProductModel.fromJson(product.data() as Map<String, dynamic>));
    });
    update();

    //? api 1 from course
    // final url =
    //     Uri.parse('https://course-49082-default-rtdb.firebaseio.com/products.json');
    // final response = await http.get(url);
    // final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //   print(json.decode(response.body));
    // if (extractedData == null) {
    //   return;
    // }
    // final List<ProductModel> loadedProducts = [];
    // extractedData.forEach((prodId, prodData) {
    //   _products.add(ProductModel(
    //       productId: prodId,
    //       det:prodData['descriptions'],
    //       name: prodData['title'],
    //       description: prodData['descriptions'],
    //       price: prodData['price'].toString(),
    //       image: prodData['imageUrl'],
    //       category: 'men',
    //       sized: 'L',
    //       color: Colors.pinkAccent,
    //       sellerId: 'R0eYNlf8UzdyqL9TvuinWaObrin2'));
    // });

    //   //! api 2 from fake ecommerce  working good with more than 200 products
    //   final url = Uri.parse(
    //       'https://fake-e-commerce-api.onrender.com/product/limit/1/40');

    //   final response = await http.get(url);
    //   print('extractedData');
    //   print(json.decode(response.body));
    //   print(json.decode(response.statusCode.toString()));
    //   final extractedData = json.decode(response.body);

    //   // print(json.decode(response.body)['name'].toString());

    //   final List<ProductModel> loadedProducts = [];
    //   if (extractedData == null) {
    //     return;
    //   }
    //   // ignore: unused_local_variable
    //   for (var item in extractedData) {
    //     _products.add(ProductModel(
    //         productId: item['_id'].toString(),
    //         category: item['category'],
    //         description: item['description'],
    //         image: item['image'],
    //         price: item['price'].toString(),
    //         sized: 'L',
    //         det: item['description'],
    //         color: Colors.lightBlue,
    //         name: item['name'],
    //         sellerId: 'R0eYNlf8UzdyqL9TvuinWaObrin2'));

    //     print(_products.length);
    //     _isloading = false;
    //     print(_isloading);
    //  _loading.value = false;

    //     update();
    //   }
    // TODO api 3 working
    // final url = Uri.parse('https://fakestoreapi.com/products');

    // final response = await http.get(url);

    // final extractedData = json.decode(response.body);
    // print(response.statusCode.toString());

    // // print(json.decode(response.body)['name'].toString());

    // final List<ProductModel> loadedProducts = [];
    // if (extractedData == null) {
    //   return;
    // }
    // // ignore: unused_local_variable
    // for (var item in extractedData) {
    //   _products.add(ProductModel(
    //       productId: item['id'].toString(),
    //       category: item['category'],
    //       description: item['title'],
    //       image: item['image'],
    //       price: item['price'].toString(),
    //       sized: 'L',
    //       det: item['description'],
    //       color: Colors.pinkAccent,
    //       name: item['title'],
    //       sellerId: 'R0eYNlf8UzdyqL9TvuinWaObrin2'));
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

  _getbidsFromFireStore() async {
    _loading.value = true;
    List<QueryDocumentSnapshot> bidsSnapshot =
        await FirestoreHome().getbidsFromFirestore();
    bidsSnapshot.forEach((user) {
      _bids.add(BidModel.fromJson(user.data() as Map<String, dynamic>));
    });
    _loading.value = false;
    update();
  }

  deleteProductsFromFireStore(String id) async {
    FirestoreSell().deleteData(id);

    products.removeWhere((prod) => prod.productId == id);
    update();
  }

  updateReview(String id, String rating, String reviews) async {
    await FirebaseFirestore.instance.collection("Products").doc(id).update({
      "reviews": reviews,
      "rating": rating,
    });
    getProductsFromFireStore();
    update();
  }


   Future updateBidCount(String id,String bids) async {
    await FirebaseFirestore.instance.collection("auctions").doc(id).update({
      "bids": bids,
      
    });
    update();
  }
}
