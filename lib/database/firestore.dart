import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class FirestoreDatabase {
  User? user = FirebaseAuth.instance.currentUser;

  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  Future<void> addPost(String message) {
    return posts.add({
      "UserEmail": user!.email,
      "PostMessage": message,
      "Timestamp": Timestamp.now()
    });
  }

  Stream<QuerySnapshot> getPostStream() {
    final PostStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("Timestamp", descending: true)
        .snapshots();

    return PostStream;
  }
}
