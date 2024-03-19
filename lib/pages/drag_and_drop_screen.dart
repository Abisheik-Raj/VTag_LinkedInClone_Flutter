// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vtag/components/button_component.dart';
import 'package:vtag/components/signup_page_progress_indicator.dart';
import 'package:vtag/components/skill_chip2.dart';
import 'package:vtag/pages/main_screen.dart';
import 'package:vtag/resources/colors.dart';
import 'package:vtag/services/auth_service.dart';

class DragAndDropScreen extends StatefulWidget {
  String username;
  String phonenumber;
  List<String> selectedSkills;
  String profilePhotoUrl;
  DragAndDropScreen({
    Key? key,
    required this.username,
    required this.phonenumber,
    required this.selectedSkills,
    required this.profilePhotoUrl,
  }) : super(key: key);

  @override
  State<DragAndDropScreen> createState() => _DragAndDropScreenState();
}

class _DragAndDropScreenState extends State<DragAndDropScreen> {
  final List<String> gettingStartedList = [];
  final List<String> knowTheBasicsList = [];
  final List<String> builtProjectsList = [];
  final List<String> workExperienceList = [];
  List<String> demoList = [];

  @override
  void initState() {
    // TODO: implement initState
    demoList = widget.selectedSkills;
    super.initState();
  }

  void removeSkillFromSelectedSkills(String skillName) {
    setState(() {
      widget.selectedSkills.remove(skillName);
    });
  }

  bool isDragging = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        gettingStartedList.clear();
                        knowTheBasicsList.clear();
                        builtProjectsList.clear();
                        workExperienceList.clear();

                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back,
                        size: 25,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const SignupPageProgessIndicator(fillColor: greenColor),
                    const SignupPageProgessIndicator(fillColor: greenColor),
                    const SignupPageProgessIndicator(fillColor: greenColor),
                  ],
                ),
                const SizedBox(height: 50),
                const Text(
                  "Drag n' drop your skills!",
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 35,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DragTarget(
                      onAcceptWithDetails: (objectWithData) {
                        setState(() {
                          gettingStartedList
                              .add(objectWithData.data.toString());
                          removeSkillFromSelectedSkills(
                              objectWithData.data.toString());
                        });
                      },
                      builder: (context, candidates, rejects) {
                        return Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(232, 233, 248, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Color.fromRGBO(161, 171, 247, 1),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Center(
                                    child: Text(
                                      "GETTING STARTED",
                                      style: TextStyle(
                                        fontFamily: "PoppinsSemiBold",
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: ListView.builder(
                                    itemCount: gettingStartedList.length,
                                    itemBuilder: (context, index) => Text(
                                      gettingStartedList[index],
                                      style: const TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    DragTarget(
                      onAcceptWithDetails: (objectWithData) {
                        setState(() {
                          knowTheBasicsList.add(objectWithData.data.toString());
                          removeSkillFromSelectedSkills(
                              objectWithData.data.toString());
                        });
                      },
                      builder: (context, candidates, rejects) {
                        return Expanded(
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(246, 239, 220, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: 180,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Color.fromRGBO(247, 223, 164, 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "KNOW THE BASICS",
                                        style: TextStyle(
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ListView.builder(
                                      itemCount: knowTheBasicsList.length,
                                      itemBuilder: (context, index) => Text(
                                        knowTheBasicsList[index],
                                        style: const TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DragTarget(
                      onAcceptWithDetails: (objectWithData) {
                        setState(() {
                          builtProjectsList.add(objectWithData.data.toString());
                          removeSkillFromSelectedSkills(
                              objectWithData.data.toString());
                        });
                      },
                      builder: (context, candidates, rejects) {
                        return Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(227, 219, 249, 1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 180,
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                  color: Color.fromRGBO(186, 155, 245, 1),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 10,
                                  ),
                                  child: Center(
                                    child: Text(
                                      "BUILT PROJECTS",
                                      style: TextStyle(
                                        fontFamily: "PoppinsSemiBold",
                                        fontSize: 15,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: ListView.builder(
                                    itemCount: builtProjectsList.length,
                                    itemBuilder: (context, index) => Text(
                                      builtProjectsList[index],
                                      style: const TextStyle(
                                        fontFamily: "PoppinsRegular",
                                        fontSize: 13,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    DragTarget(
                      onAcceptWithDetails: (objectWithData) {
                        setState(() {
                          workExperienceList
                              .add(objectWithData.data.toString());
                          removeSkillFromSelectedSkills(
                              objectWithData.data.toString());
                        });
                      },
                      builder: (context, candidates, rejects) {
                        return Expanded(
                          child: Container(
                            height: 180,
                            width: 180,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(226, 243, 229, 1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 180,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    color: Color.fromRGBO(180, 233, 183, 1),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 10,
                                    ),
                                    child: Center(
                                      child: Text(
                                        "WORK EXPERIENCE",
                                        style: TextStyle(
                                          fontFamily: "PoppinsSemiBold",
                                          fontSize: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: ListView.builder(
                                      itemCount: workExperienceList.length,
                                      itemBuilder: (context, index) => Text(
                                        workExperienceList[index],
                                        style: const TextStyle(
                                          fontFamily: "PoppinsRegular",
                                          fontSize: 13,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                if (widget.selectedSkills.isNotEmpty)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "🤖 Match skills to your experience level",
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "${widget.selectedSkills.length} left",
                        style: const TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 15,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 10),
                if (widget.selectedSkills.isNotEmpty)
                  Wrap(
                    spacing: 10,
                    runSpacing: 8,
                    children: List.generate(
                      widget.selectedSkills.length,
                      (index) => Container(
                        child: Draggable(
                          childWhenDragging: Container(),
                          data: widget.selectedSkills[index],
                          feedback: Text(
                            widget.selectedSkills[index],
                            style: const TextStyle(
                              fontFamily: "PoppinsRegular",
                              fontSize: 15,
                              color: greyColor,
                            ),
                          ),
                          child: SkillChip2(
                            skillName: widget.selectedSkills[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                if (widget.selectedSkills.isEmpty)
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
                          "selectedskills": demoList,
                          "gettingstarted": gettingStartedList,
                          "knowthebasics": knowTheBasicsList,
                          "builtprojects": builtProjectsList,
                          "workexperience": workExperienceList,
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
                      },
                      child: const ButtonComponent(text: "Next"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
