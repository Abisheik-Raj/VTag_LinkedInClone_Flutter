import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vtag/resources/post.dart';

class FirebaseMethods {
  bool uploadPost(Post post) {
    try {
      final postJsonifed = post.toJson();

      FirebaseFirestore.instance
          .collection("posts")
          .doc(postJsonifed["postUID"])
          .set(postJsonifed);

      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "posts": FieldValue.arrayUnion([postJsonifed["postUID"]]),
      });

      return true;
    } catch (e) {
      return false;
    }
  }
}
