import "dart:io";

import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:image_picker/image_picker.dart";
import "package:vtag/components/button_component.dart";
import "package:vtag/components/button_component2.dart";
import "package:vtag/components/textfield_component2.dart";
import "package:vtag/components/signup_page_progress_indicator.dart";
import "package:vtag/pages/skill_selection_screen.dart";
import "package:vtag/resources/colors.dart";
import "package:vtag/resources/image_selector.dart";
import "package:vtag/services/storage_methods.dart";

class ProfileCreationScreen extends StatefulWidget {
  const ProfileCreationScreen({super.key});

  @override
  State<ProfileCreationScreen> createState() => _ProfileCreationScreenState();
}

class _ProfileCreationScreenState extends State<ProfileCreationScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phonenumberController = TextEditingController();

  Uint8List? profileImage;
  bool loading = false;

  StorageMethods storageMethods = StorageMethods();

  @override
  Widget build(BuildContext context) {
    showDialogBox(context) {
      return showDialog(
          context: (context),
          builder: (context) {
            return SimpleDialog(
              title: const Text("Pick a image for your profile photo"),
              titleTextStyle: const TextStyle(
                  fontFamily: "PoppinsSemiBold",
                  fontSize: 20,
                  color: Colors.black),
              children: [
                SimpleDialogOption(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      var file = await pickImage(ImageSource.camera);
                      setState(() {
                        profileImage = file;
                      });
                    },
                    child: const Text(
                      "Open Camera",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                ),
                SimpleDialogOption(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      var file = await pickImage(ImageSource.gallery);
                      setState(() {
                        profileImage = file;
                      });
                    },
                    child: const Text(
                      "Open Gallery",
                      style: TextStyle(
                          fontFamily: "PoppinsRegular",
                          fontSize: 18,
                          color: Colors.black),
                    ),
                  ),
                )
              ],
            );
          });
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SignupPageProgessIndicator(fillColor: blueColor),
                      SignupPageProgessIndicator(
                          fillColor: Color.fromARGB(255, 223, 220, 220)),
                      SignupPageProgessIndicator(
                          fillColor: Color.fromARGB(255, 223, 220, 220)),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Welcome User!",
                    style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 35,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Let's build your profile together 👋",
                    style: TextStyle(
                        fontFamily: "PoppinsRegular",
                        fontSize: 15,
                        color: greyColor),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Stack(children: [
                      profileImage == null
                          ? const CircleAvatar(
                              radius: 65,
                              backgroundImage: AssetImage(
                                  "assets\\images\\profile_avatar.jpg"),
                            )
                          : CircleAvatar(
                              radius: 65,
                              backgroundImage: MemoryImage(profileImage!),
                            ),
                      Positioned(
                        bottom: 1,
                        right: 0,
                        child: GestureDetector(
                          onTap: () {
                            showDialogBox(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 3,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(100)),
                            child: const Icon(Icons.camera_alt_rounded,
                                color: blueColor),
                          ),
                        ),
                      )
                    ]),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const Text(
                    "Full name",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsRegular",
                        fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  TextFieldComponent2(
                    controller: usernameController,
                    hintText: "John Watson",
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Phone number",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "PoppinsRegular",
                        fontSize: 15),
                  ),
                  const SizedBox(height: 10),
                  TextFieldComponent2(
                    controller: phonenumberController,
                    hintText: "+91 8422349510",
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });

                        try {
                          if (profileImage == null) {
                            ByteData imageData = await rootBundle
                                .load('assets/images/profile_avatar.jpg');
                            profileImage = imageData.buffer.asUint8List();
                          }

                          String profilePhotoAsString =
                              await storageMethods.uploadImageToStorage(
                                  "profilePics", profileImage!, false);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SkillSelectionScreen(
                                        username: usernameController.text,
                                        phonenumber: phonenumberController.text,
                                        profilePhotoUrl: profilePhotoAsString,
                                      )));
                        } catch (e) {
                          print("Error while uploading profile image");
                        } finally {
                          setState(() {
                            loading = false;
                          });
                        }
                      },
                      child: loading == true
                          ? const ButtonComponent2()
                          : const ButtonComponent(text: "Next"))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
