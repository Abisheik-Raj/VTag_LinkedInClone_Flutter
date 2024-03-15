import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vtag/pages/otp_verification_screen.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  Future<UserCredential> login(
      String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      logout();
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  OTPVerificationScreen(email: email, password: password)));

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> login2(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  Future<UserCredential> signup(String email, String password) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      firebaseFirestore
          .collection("users")
          .doc(firebaseAuth.currentUser!.uid)
          .set({"email": email, "signupdone": false});

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  void confirmSignupDoneByUser() {
    firebaseFirestore
        .collection("users")
        .doc(firebaseAuth.currentUser!.uid)
        .update({"signupdone": true});
  }

  void logout() async {
    firebaseAuth.signOut();
    notifyListeners();
  }
}
