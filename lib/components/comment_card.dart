import "package:flutter/material.dart";
import "package:vtag/resources/colors.dart";

class CommentCard extends StatelessWidget {
  final snap;
  const CommentCard({super.key, required this.snap});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            minRadius: 25,
            foregroundImage: NetworkImage(snap["profileImgUrl"]),
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
                      text: snap["username"],
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsSemibold",
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: "  @${(snap["email"]).split("@")[0]}",
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
                Text(
                  snap["description"],
                  maxLines: 5,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: "PoppinsRegular",
                      fontSize: 15,
                      overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
