import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:vtag/components/post_component.dart";
import "package:vtag/resources/colors.dart";

class ProfileScreen extends StatefulWidget {
  String userUID;
  ProfileScreen({super.key, required this.userUID});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    final UID = FirebaseAuth.instance.currentUser!.uid;

    return SafeArea(
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.black,
          body: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(widget.userUID)
                  .snapshots(),
              builder: (context, snapshots) {
                if (snapshots.hasData) {
                  final userData = snapshots.data!.data();

                  return Stack(children: [
                    SizedBox(
                      height: screenSize.height * 1,
                      child: ListView(
                        children: [
                          Container(
                            height: screenSize.height * 0.14,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                        userData!["profilePhotoUrl"]))),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Container(
                              height: screenSize.height * 1,
                              transform:
                                  Matrix4.translationValues(0.0, -40, 0.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            userData["profilePhotoUrl"]),
                                      ),
                                      UID == widget.userUID
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 25,
                                                      vertical: 6),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black,
                                              ),
                                              child: const Text(
                                                "Edit Profile",
                                                style: TextStyle(
                                                    fontFamily:
                                                        "PoppinsSemiBold",
                                                    color: Colors.white),
                                              ),
                                            )
                                          : StreamBuilder(
                                              stream: FirebaseFirestore.instance
                                                  .collection("users")
                                                  .doc(FirebaseAuth.instance
                                                      .currentUser!.uid)
                                                  .snapshots(),
                                              builder: (context, snapshots) {
                                                if (snapshots.hasData) {
                                                  final snapData =
                                                      snapshots.data!.data();

                                                  return GestureDetector(
                                                    onTap: () {
                                                      if (snapData["following"]
                                                          .contains(
                                                              widget.userUID)) {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .update({
                                                          "following":
                                                              FieldValue
                                                                  .arrayRemove([
                                                            widget.userUID
                                                          ])
                                                        });

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(widget.userUID)
                                                            .update({
                                                          "following":
                                                              FieldValue
                                                                  .arrayRemove([
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                          ])
                                                        });
                                                      } else {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid)
                                                            .update({
                                                          "following":
                                                              FieldValue
                                                                  .arrayUnion([
                                                            widget.userUID
                                                          ])
                                                        });

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("users")
                                                            .doc(widget.userUID)
                                                            .update({
                                                          "following":
                                                              FieldValue
                                                                  .arrayUnion([
                                                            FirebaseAuth
                                                                .instance
                                                                .currentUser!
                                                                .uid
                                                          ])
                                                        });
                                                      }
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 25,
                                                          vertical: 6),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Colors.white,
                                                      ),
                                                      child: snapData![
                                                                      "following"]
                                                                  .contains(widget
                                                                      .userUID) ==
                                                              true
                                                          ? const Text(
                                                              "UnFollow",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "PoppinsSemiBold",
                                                                  color: Colors
                                                                      .black),
                                                            )
                                                          : const Text(
                                                              "Follow",
                                                              style: TextStyle(
                                                                  fontFamily:
                                                                      "PoppinsSemiBold",
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              }),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    userData["username"],
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: "PoppinsSemiBold",
                                        fontSize: 20),
                                  ),
                                  Text(
                                    userData["email"].split("@")[0],
                                    style: const TextStyle(
                                        color: greyColor,
                                        fontFamily: "PoppinsRegular",
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Row(
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: userData["following"]
                                              .length
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "PoppinsSemibold",
                                              fontSize: 12),
                                          children: const [
                                            TextSpan(
                                                text: "  Following",
                                                style: TextStyle(
                                                    color: greyColor,
                                                    fontFamily:
                                                        "PoppinsSemibold",
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: userData["following"]
                                              .length
                                              .toString(),
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: "PoppinsSemibold",
                                              fontSize: 12),
                                          children: const [
                                            TextSpan(
                                                text: "  Followers",
                                                style: TextStyle(
                                                    color: greyColor,
                                                    fontFamily:
                                                        "PoppinsSemibold",
                                                    fontSize: 12)),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  const TabBar(
                                    tabAlignment: TabAlignment.start,
                                    isScrollable: true,
                                    indicatorColor: blueColor,
                                    dividerColor: greyColor,
                                    dividerHeight: 0.0,
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 15,
                                    ),
                                    unselectedLabelStyle: TextStyle(
                                      color: greyColor,
                                      fontFamily: "PoppinsSemiBold",
                                      fontSize: 15,
                                    ),
                                    tabs: [
                                      Tab(
                                        text: "Posts",
                                      ),
                                      Tab(
                                        text: "Favourites",
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    height: screenSize.height * 0.5,
                                    child: TabBarView(children: [
                                      Expanded(
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(widget.userUID)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              var snap = snapshot.data!.data();
                                              var posts = snap!["posts"];

                                              if (posts.isEmpty) {
                                                return const Center(
                                                    child: Text(
                                                  "No Posts Yet!",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "PoppinsSemibold",
                                                      fontSize: 20),
                                                ));
                                              }
                                              return ListView.builder(
                                                  itemCount: posts.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "posts")
                                                                .doc(posts[
                                                                    index])
                                                                .snapshots(),
                                                        builder:
                                                            (context, snaps) {
                                                          if (snaps.hasData) {
                                                            final snapData =
                                                                snaps.data!
                                                                    .data();

                                                            return Column(
                                                              children: [
                                                                PostComponent(
                                                                    userPosts:
                                                                        true,
                                                                    onTapDelete:
                                                                        () {},
                                                                    snap:
                                                                        snapData),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Divider(
                                                                  thickness:
                                                                      0.7,
                                                                  color:
                                                                      greyColor,
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                              ],
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    blueColor,
                                                              ),
                                                            );
                                                          }
                                                        });
                                                  });
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: blueColor,
                                              ));
                                            }
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: StreamBuilder(
                                          stream: FirebaseFirestore.instance
                                              .collection("users")
                                              .doc(widget.userUID)
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              var snap = snapshot.data!.data();
                                              var posts = snap!["favourites"];

                                              if (posts.isEmpty) {
                                                return const Center(
                                                    child: Text(
                                                  "No Favourites Yet!",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily:
                                                          "PoppinsSemibold",
                                                      fontSize: 20),
                                                ));
                                              }
                                              return ListView.builder(
                                                  itemCount: posts.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    return StreamBuilder(
                                                        stream:
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    "posts")
                                                                .doc(posts[
                                                                    index])
                                                                .snapshots(),
                                                        builder:
                                                            (context, snaps) {
                                                          if (snaps.hasData) {
                                                            final snapData =
                                                                snaps.data!
                                                                    .data();

                                                            return Column(
                                                              children: [
                                                                PostComponent(
                                                                    userPosts:
                                                                        true,
                                                                    onTapDelete:
                                                                        () {},
                                                                    snap:
                                                                        snapData),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                                const Divider(
                                                                  thickness:
                                                                      0.7,
                                                                  color:
                                                                      greyColor,
                                                                ),
                                                                const SizedBox(
                                                                  height: 15,
                                                                ),
                                                              ],
                                                            );
                                                          } else {
                                                            return const Center(
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    blueColor,
                                                              ),
                                                            );
                                                          }
                                                        });
                                                  });
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator(
                                                color: blueColor,
                                              ));
                                            }
                                          },
                                        ),
                                      ),
                                    ]),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: screenSize.height * 0.06,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: 0.8,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.black),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            Opacity(
                              opacity: 0.8,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.black),
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]);
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: blueColor,
                    ),
                  );
                }
              }),
        ),
      ),
    );
  }
}
