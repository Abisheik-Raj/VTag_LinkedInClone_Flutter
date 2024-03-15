// ignore_for_file: avoid_unnecessary_containers

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:vtag/pages/main_screen.dart";
import "package:vtag/pages/profile_creation_screen.dart";

class DecisionScreen extends StatelessWidget {
  const DecisionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    return StreamBuilder(
        stream: firebaseFirestore
            .collection("users")
            .doc(firebaseAuth.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.waiting) {
            return Container(
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            );
          } else if (snapshots.hasError) {
            return Container(
                child: const Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            ));
          } else {
            final userData = snapshots.data!.data();
            final signupdone = userData!["signupdone"];
            print(signupdone);

            if (signupdone == true) {
              return const MainScreen();
            } else {
              return const ProfileCreationScreen();
            }
          }
        });
  }
}
