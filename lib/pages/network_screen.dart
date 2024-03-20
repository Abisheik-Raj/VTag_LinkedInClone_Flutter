import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:vtag/components/search_component.dart";
import "package:vtag/components/user_name_card_component.dart";
import "package:vtag/resources/colors.dart";

class NetworkScreen extends StatefulWidget {
  NetworkScreen({super.key});

  @override
  State<NetworkScreen> createState() => _NetworkScreenState();
}

class _NetworkScreenState extends State<NetworkScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          height: screenSize.height * 1,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SearchComponent(
                        controller: searchController,
                        onSubmitted: (value) {
                          setState(() {});
                        },
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            searchController.text = "";
                          });
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontFamily: "PoppinsRegular",
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  searchController.text.isNotEmpty
                      ? StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users")
                              .where("username",
                                  isGreaterThan: searchController.text)
                              .snapshots(),
                          builder: (context, snapshots) {
                            if (snapshots.hasData) {
                              final snapDocs = snapshots.data!.docs;

                              return SizedBox(
                                height: screenSize.height * 1,
                                child: ListView.builder(
                                    itemCount: snapDocs.length,
                                    itemBuilder: (context, index) {
                                      if (snapDocs[index].id ==
                                          FirebaseAuth
                                              .instance.currentUser!.uid) {
                                        return Container();
                                      }

                                      return UserNameCardComponent(
                                        snap: snapDocs[index].data(),
                                        uid: snapDocs[index].id,
                                      );
                                    }),
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(
                                  color: blueColor,
                                ),
                              );
                            }
                          })
                      : const Center(
                          child: Text(
                            "Try searching for people",
                            style: TextStyle(
                                color: greyColor, fontFamily: "PoppinsRegular"),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
