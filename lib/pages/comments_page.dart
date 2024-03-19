import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:uuid/uuid.dart";
import "package:vtag/components/comment_card.dart";
import "package:vtag/components/snackbar_component.dart";
import "package:vtag/resources/colors.dart";
import "package:vtag/resources/comment.dart";

class CommentsPage extends StatefulWidget {
  final snap;
  CommentsPage({super.key, required this.snap});

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final TextEditingController commentController = TextEditingController();
  bool commentPreparing = false;
  bool approveToBePosted = false;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(children: [
          Container(
            color: Colors.black,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Cancel",
                          style: TextStyle(
                              fontFamily: "PoppinsRegular",
                              color: Colors.white,
                              fontSize: 17),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          try {
                            if (commentController.text.isNotEmpty) {
                              setState(() {
                                commentPreparing = true;
                              });

                              String commentUID = const Uuid().v1();

                              final userData = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get();

                              Comment comment = Comment(
                                commentUID: commentUID,
                                description: commentController.text,
                                datePublished: DateTime.now(),
                                username: userData["username"],
                                email: userData["username"],
                                profileImgUrl: userData["profilePhotoUrl"],
                              );

                              setState(() {
                                commentController.text = "";
                              });

                              Map<String, dynamic> commentJsonified =
                                  comment.toJson();

                              FirebaseFirestore.instance
                                  .collection("posts")
                                  .doc(widget.snap["postUID"])
                                  .collection("comments")
                                  .doc(commentUID)
                                  .set(commentJsonified);

                              FirebaseFirestore.instance
                                  .collection("posts")
                                  .doc(widget.snap["postUID"])
                                  .update({
                                "comments": FieldValue.arrayUnion([commentUID])
                              });
                            }
                          } catch (e) {
                            showSnackbar(context, e.toString());
                            setState(() {
                              commentPreparing = false;
                            });
                          } finally {
                            setState(() {
                              commentPreparing = false;
                            });
                          }
                        },
                        child: Opacity(
                          opacity: approveToBePosted == true ? 1 : 0.5,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: blueColor,
                            ),
                            child: const Text(
                              "Comment",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                commentPreparing == false
                    ? const Divider(
                        color: greyColor,
                        thickness: 0.5,
                      )
                    : const LinearProgressIndicator(
                        minHeight: 0.5,
                        color: blueColor,
                      ),
                StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("posts")
                        .doc(widget.snap["postUID"])
                        .collection("comments")
                        .orderBy("datePublished", descending: true)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: blueColor,
                          ),
                        );
                      } else {
                        final snaps = snapshot.data!.docs;

                        return Expanded(
                          child: ListView.builder(
                              itemCount: snaps.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: CommentCard(snap: snaps[index]),
                                );
                              }),
                        );
                      }
                    }),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: screenSize.height * 0.15,
              width: screenSize.width * 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    color: greyColor,
                    thickness: 0.5,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: RichText(
                        text: const TextSpan(
                            text: "Replying to ",
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                color: greyColor,
                                fontSize: 12),
                            children: [
                          TextSpan(
                              text: "",
                              style: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: greyColor,
                                  fontSize: 12),
                              children: [
                                TextSpan(
                                  text: "@Abisheik Raj",
                                  style: TextStyle(
                                      fontFamily: "PoppinsRegular",
                                      color: blueColor,
                                      fontSize: 12),
                                ),
                              ])
                        ])),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      onChanged: (value) {
                        if (value == "") {
                          approveToBePosted = false;
                          setState(() {});
                        } else {
                          if (approveToBePosted != true) {
                            setState(() {
                              approveToBePosted = true;
                            });
                          }
                        }
                      },
                      controller: commentController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: "Post your comment",
                        hintStyle: TextStyle(
                          fontFamily: "PoppinsRegular",
                          color: greyColor,
                          fontSize: 15,
                        ),
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
