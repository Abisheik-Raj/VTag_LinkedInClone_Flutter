import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:vtag/components/search_component.dart";
import "package:vtag/resources/colors.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: lightWhiteColor,
      // appBar: AppBar(
      //   title: const SearchComponent(),
      //   actions: [
      //     IconButton(
      //       onPressed: () {
      //         Navigator.push(context,
      //             MaterialPageRoute(builder: (context) => PostScreen()));
      //       },
      //       icon: const Icon(
      //         Icons.post_add,
      //         size: 30,
      //       ),
      //       padding: const EdgeInsets.symmetric(horizontal: 0),
      //     )
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                color: Colors.white,
              ),
              height: screenSize.height * 0.08,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.uid)
                          .snapshots(),
                      builder: ((context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircleAvatar(
                            foregroundImage: AssetImage(
                                "assets\\images\\profile_avatar.jpg"),
                          );
                        } else if (snapshot.hasError) {
                          return const CircleAvatar(
                            foregroundImage: AssetImage(
                                "assets\\images\\profile_avatar.jpg"),
                          );
                        } else {
                          try {
                            final userData = snapshot.data!.data();

                            return CircleAvatar(
                              foregroundImage:
                                  NetworkImage(userData!["profilePhotoUrl"]),
                            );
                          } catch (e) {
                            return const CircleAvatar(
                              foregroundImage: AssetImage(
                                  "assets\\images\\profile_avatar.jpg"),
                            );
                          }
                        }
                      }),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  const SearchComponent()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
