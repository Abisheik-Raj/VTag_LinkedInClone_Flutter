import "package:flutter/material.dart";
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import "package:vtag/resources/colors.dart";

class PostComponent extends StatelessWidget {
  final snap;
  const PostComponent({super.key, required this.snap});

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
                Image(image: NetworkImage(snap["imageUrls"][0])),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      MdiIcons.commentOutline,
                      color: greyColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${snap["comments"].length}",
                      style: const TextStyle(
                          color: greyColor,
                          fontFamily: "PoppinsSemibold",
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    const Icon(
                      Icons.favorite_outline_rounded,
                      color: greyColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${snap["likes"].length}",
                      style: const TextStyle(
                          color: greyColor,
                          fontFamily: "PoppinsSemibold",
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Icon(
                      MdiIcons.download,
                      color: greyColor,
                      size: 21,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${snap["downloads"].length}",
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
