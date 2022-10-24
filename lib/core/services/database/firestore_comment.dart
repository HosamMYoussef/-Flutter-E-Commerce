import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myshopp/model/comment_model.dart';

class FireStoreComment extends GetxController {
  late final CollectionReference _commentsCollection =
      FirebaseFirestore.instance.collection('comments');

  Future<List<QueryDocumentSnapshot>> getcommentsFromFirestore() async {
    var _comments =
        await _commentsCollection.orderBy('date', descending: true).get();
    return _comments.docs;
  }

  addCommentToFirestore(CommentModel commentModel) async {
    await _commentsCollection.doc().set(commentModel.toJson());
  }
}
