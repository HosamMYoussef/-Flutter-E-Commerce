import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:myshopp/model/comment_model.dart';
import 'package:intl/intl.dart';

import '../services/database/firestore_comment.dart';

class CommentViewModel extends GetxController {
  String? productid, details, name, pic;

  addCommentsToFireStore() async {
    await FireStoreComment().addCommentToFirestore(CommentModel(
      details: details!,
      name: name!,
      pic: pic!,
      productId: productid!,
      date: DateFormat.yMMMd().format(DateTime.now()),
    ));
  }
}
