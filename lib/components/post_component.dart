import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import "package:vtag/pages/comments_page.dart";
import "package:vtag/resources/colors.dart";

class PostComponent extends StatefulWidget {
  final snap;
  const PostComponent({super.key, required this.snap});

  @override
  State<PostComponent> createState() => _PostComponentState();
}

class _PostComponentState extends State<PostComponent> {
  int currentIndexOfImage = 0;
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    // ignore: avoid_unnecessary_containers
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            minRadius: 25,
            foregroundImage: NetworkImage(widget.snap["profileImgUrl"]),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                      text: widget.snap["username"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemibold",
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: "  @${(widget.snap["email"]).split("@")[0]}",
                          style: const TextStyle(
                              color: greyColor,
                              fontFamily: "PoppinsRegular",
                              fontSize: 15),
                        )
                      ]),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommentsPage(
                                  snap: widget.snap,
                                )));
                  },
                  child: Text(
                    widget.snap["description"],
                    maxLines: 5,
                    style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsRegular",
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(height: 20),
                Stack(children: [
                  SizedBox(
                    height: screenSize.height * 0.5,
                    child: PageView.builder(
                        onPageChanged: (value) {
                          setState(() {
                            currentIndexOfImage = value;
                          });
                        },
                        itemCount: (widget.snap["imageUrls"] as List).length,
                        itemBuilder: (context, index) {
                          return Image(
                            image: NetworkImage(
                                widget.snap["imageUrls"][currentIndexOfImage]),
                          );
                        }),
                  ),
                  Positioned(
                    top: 10,
                    right: 9,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.black,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 8),
                      child: Text(
                        "${currentIndexOfImage + 1}  /  ${(widget.snap["imageUrls"] as List).length}",
                        style: const TextStyle(
                            fontFamily: "PoppinsSemibold",
                            color: Colors.white,
                            fontSize: 10),
                      ),
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CommentsPage(
                                      snap: widget.snap,
                                    )));
                      },
                      child: Icon(
                        MdiIcons.commentOutline,
                        color: greyColor,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.snap["comments"].length}",
                      style: const TextStyle(
                          color: greyColor,
                          fontFamily: "PoppinsSemibold",
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    widget.snap["likes"]
                            .contains(FirebaseAuth.instance.currentUser!.uid)
                        ? GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("posts")
                                  .doc(widget.snap["postUID"])
                                  .update({
                                "likes": FieldValue.arrayRemove(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.favorite_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                          )
                        : GestureDetector(
                            onTap: () {
                              FirebaseFirestore.instance
                                  .collection("posts")
                                  .doc(widget.snap["postUID"])
                                  .update({
                                "likes": FieldValue.arrayUnion(
                                    [FirebaseAuth.instance.currentUser!.uid])
                              });
                              setState(() {});
                            },
                            child: const Icon(
                              Icons.favorite_outline_rounded,
                              color: greyColor,
                              size: 20,
                            ),
                          ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.snap["likes"].length}",
                      style: const TextStyle(
                          color: greyColor,
                          fontFamily: "PoppinsSemibold",
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Icon(
                        MdiIcons.download,
                        color: greyColor,
                        size: 21,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.snap["downloads"].length}",
                      style: const TextStyle(
                          color: greyColor,
                          fontFamily: "PoppinsSemibold",
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Icon(
            Icons.more_horiz,
            color: greyColor,
          )
        ],
      ),
    );
  }
}
