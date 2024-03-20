// ignore_for_file: must_be_immutable

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:vtag/components/button_component.dart";
import "package:vtag/components/signup_page_progress_indicator.dart";
import "package:vtag/components/skill_chip.dart";
import "package:vtag/pages/drag_and_drop_screen.dart";
import "package:vtag/pages/main_screen.dart";
import "package:vtag/resources/colors.dart";
import "package:vtag/resources/skill_set.dart";
import "package:vtag/services/auth_service.dart";

class SkillSelectionScreen extends StatefulWidget {
  String username;
  String phonenumber;
  String profilePhotoUrl;
  SkillSelectionScreen(
      {super.key,
      required this.username,
      required this.phonenumber,
      required this.profilePhotoUrl});

  @override
  State<SkillSelectionScreen> createState() => _SkillSelectionScreenState();
}

class _SkillSelectionScreenState extends State<SkillSelectionScreen> {
  var noOfSkillsSelected = 0;

  List<String> userSkillList = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SignupPageProgessIndicator(fillColor: blueColor),
                    const SignupPageProgessIndicator(fillColor: blueColor),
                    const SignupPageProgessIndicator(
                        fillColor: Color.fromARGB(255, 223, 220, 220)),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Tell us about your skills",
                  style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 35,
                      color: Colors.white),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Which skills are you good at or interested in learning? Pick at least 1️⃣",
                  style: TextStyle(
                      fontFamily: "PoppinsRegular",
                      fontSize: 15,
                      color: greyColor),
                ),
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  height: 450,
                  child: ListView.builder(
                      itemCount: skillSet.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              skillSet[index]["title"].toString(),
                              style: const TextStyle(
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                            const SizedBox(height: 5),
                            Wrap(
                              spacing: 10,
                              runSpacing: 5,
                              children: List.generate(
                                  skillSet[index]["skills"].length,
                                  (innerindex) => SkillChip(
                                        chipLabel: skillSet[index]["skills"]
                                            [innerindex],
                                        increaseNoOfSkills: () {
                                          setState(() {
                                            if (noOfSkillsSelected != 10) {
                                              noOfSkillsSelected++;
                                              userSkillList.add(skillSet[index]
                                                  ["skills"][innerindex]);
                                            }
                                          });
                                        },
                                        decreaseNoOfSkills: () {
                                          setState(() {
                                            if (noOfSkillsSelected != 0) {
                                              noOfSkillsSelected--;
                                              userSkillList.remove(
                                                  skillSet[index]["skills"]
                                                      [innerindex]);
                                            }
                                          });
                                        },
                                        getNumberOfItems: () =>
                                            noOfSkillsSelected,
                                      )),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "$noOfSkillsSelected / 10 selected",
                      style: const TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 18,
                          color: Colors.white),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                    onTap: () {
                      final FirebaseFirestore firebaseFirestore =
                          FirebaseFirestore.instance;
                      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

                      firebaseFirestore
                          .collection("users")
                          .doc(firebaseAuth.currentUser!.uid)
                          .update({
                        "username": widget.username,
                        "phonenumber": widget.phonenumber,
                        "selectedskills": userSkillList,
                        "gettingstarted": [],
                        "knowthebasics": [],
                        "builtprojects": [],
                        "workexperience": [],
                        "profilePhotoUrl": widget.profilePhotoUrl,
                        "following": [],
                        "followers": [],
                        "favourites": [],
                      });

                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()),
                          (route) => false);

                      Provider.of<AuthService>(context, listen: false)
                          .confirmSignupDoneByUser();

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => DragAndDropScreen(
                      //             username: widget.username,
                      //             phonenumber: widget.phonenumber,
                      //             selectedSkills: userSkillList,
                      //             profilePhotoUrl: widget.profilePhotoUrl,
                      //           )),
                      // );
                    },
                    child: const ButtonComponent(text: "Next")),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
