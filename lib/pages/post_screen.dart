import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import "package:uuid/uuid.dart";
import "package:vtag/components/snackbar_component.dart";
import "package:vtag/resources/colors.dart";
import "package:vtag/resources/image_selector.dart";
import "package:vtag/resources/post.dart";
import "package:vtag/services/firebase_methods.dart";
import "package:vtag/services/storage_methods.dart";

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final TextEditingController postController = TextEditingController();
  var image;
  List selectedImages = [];
  bool postIsPreparing = false;

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              color: Colors.black,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
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
                            if (postController.text.isNotEmpty) {
                              setState(() {
                                postIsPreparing = true;
                              });
                              var listWithImagesUrl = [];
                              if (selectedImages.isNotEmpty) {
                                for (var image in selectedImages) {
                                  listWithImagesUrl.add(await StorageMethods()
                                      .uploadImageToStorage(
                                          "posts", image, true));
                                }
                              }

                              final userData = await FirebaseFirestore.instance
                                  .collection("users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .get();

                              Post post = Post(
                                description: postController.text,
                                postUID: const Uuid().v1(),
                                username: userData["username"],
                                imageUrls: selectedImages.isEmpty
                                    ? []
                                    : listWithImagesUrl,
                                likes: [],
                                profileImgUrl: userData["profilePhotoUrl"],
                                publishedDateTime: DateTime.now(),
                                email: userData["email"],
                              );

                              final uploadPostResponse =
                                  FirebaseMethods().uploadPost(post);

                              if (uploadPostResponse == true) {
                                setState(() {
                                  postIsPreparing = true;
                                });
                                Navigator.pop(context);
                              } else {
                                setState(() {
                                  postIsPreparing = false;
                                });
                                showSnackbar(context, "Post not uploaded!");
                              }
                            }
                          },
                          child: Opacity(
                            opacity: postController.text.isNotEmpty ? 1 : 0.5,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 5),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                color: blueColor,
                              ),
                              child: const Text(
                                "Post",
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
                  postIsPreparing == false
                      ? const Divider(
                          color: greyColor,
                          thickness: 0.5,
                        )
                      : const LinearProgressIndicator(
                          minHeight: 0.5,
                          color: blueColor,
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          foregroundImage:
                              AssetImage("assets\\images\\profile_yellow.jpg"),
                          minRadius: 20,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: TextField(
                            onChanged: (value) {
                              setState(() {});
                            },
                            controller: postController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: "What's happening?",
                              hintStyle: TextStyle(
                                  fontFamily: "PoppinsRegular",
                                  color: greyColor,
                                  fontSize: 15),
                            ),
                            style: const TextStyle(
                                fontFamily: "PoppinsRegular",
                                color: Colors.white,
                                fontSize: 15),
                            cursorColor: Colors.white,
                            maxLines: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              right: 0,
              bottom: 1.5,
              child: SizedBox(
                width: screenSize.width * 1,
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedImages.length,
                          itemBuilder: (context, index) {
                            return Stack(children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                height: screenSize.height * 0.3,
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
                                  child: Image(
                                      image:
                                          MemoryImage(selectedImages[index])),
                                ),
                              ),
                              Positioned(
                                top: 10,
                                right: 9,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedImages.removeAt(index);
                                    });
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 0),
                                    child: const Text(
                                      "×",
                                      style: TextStyle(
                                          fontFamily: "PoppinsSemibold",
                                          color: Colors.white,
                                          fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            ]);
                          }),
                    ),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: greyColor, width: 0.5),
                        ),
                      ),
                      padding: const EdgeInsets.only(top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Icon(
                            MdiIcons.earth,
                            color: blueColor,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "Everyone can reply",
                            style: TextStyle(
                                fontFamily: "PoppinsRegular",
                                color: blueColor,
                                fontSize: 12),
                          ),
                          SizedBox(
                            width: screenSize.width * 0.35,
                          ),
                          GestureDetector(
                            onTap: () async {
                              image = await pickImage(ImageSource.camera);
                              setState(() {
                                if (image != null) {
                                  selectedImages.add(image);
                                }
                              });
                            },
                            child: const Icon(
                              Icons.photo_camera,
                              color: blueColor,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          GestureDetector(
                            onTap: () async {
                              image = await pickImage(ImageSource.gallery);
                              setState(() {
                                if (image != null) {
                                  selectedImages.add(image);
                                }
                              });
                            },
                            child: const Icon(
                              Icons.photo_library_outlined,
                              color: blueColor,
                              size: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
