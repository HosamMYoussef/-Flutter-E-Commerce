import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/bid_model.dart';
import 'package:myshopp/model/comment_model.dart';
import 'package:intl/intl.dart';

import '../services/home_Services.dart';

class AuctionViewModel extends GetxController {
  String? name, image, description,  price, productId, category,end,start,bids;
  String? type ;
  String? condition ;
  String? userID ;


   addBidToFireStore() async {
    await FirestoreHome().addBidToFirestore(BidModel(
     auctionId:productId! ,
     price: price!,
     userId: FirebaseAuth.instance.currentUser!.uid,

    ));
  }
}

