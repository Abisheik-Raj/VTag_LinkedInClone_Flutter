import "package:flutter/material.dart";
import "package:vtag/pages/profile_screen.dart";
import "package:vtag/resources/colors.dart";

class UserNameCardComponent extends StatelessWidget {
  final snap;
  final uid;
  const UserNameCardComponent(
      {super.key, required this.snap, required this.uid});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Container(
        color: Colors.black,
        width: screenSize.width * 1,
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(snap["profilePhotoUrl"]),
            ),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileScreen(userUID: uid)));
                  },
                  child: RichText(
                    text: TextSpan(
                      text: snap["username"],
                      style: const TextStyle(
                          color: Colors.white, fontFamily: "PoppinsSemibold"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 2.5,
                ),
                RichText(
                  text: TextSpan(
                    text: "@${snap["email"].split("@")[0]}",
                    style: const TextStyle(
                        color: greyColor, fontFamily: "PoppinsRegular"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
