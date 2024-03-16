// ignore_for_file: must_be_immutable

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:image_picker/image_picker.dart";
import "package:vtag/components/snackbar_component.dart";
import "package:vtag/resources/colors.dart";
import "package:vtag/resources/image_selector.dart";
import "package:vtag/resources/post.dart";
import "package:vtag/services/firebase_methods.dart";
import "package:vtag/services/storage_methods.dart";
import 'package:uuid/uuid.dart';

class PostScreen extends StatefulWidget {
  PostScreen({super.key});
  var image;

  List selectedImages = [];

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  StorageMethods storageMethods = StorageMethods();
  TextEditingController postController = TextEditingController();
  Uuid uuid = const Uuid();

  @override
  void dispose() {
    postController.dispose();
    super.dispose();
  }

  selectImage(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text(
          "Create a Post",
          style: TextStyle(fontFamily: "PoppinsSemiBold", fontSize: 20),
        ),
        children: [
          SimpleDialogOption(
            child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                widget.image = await pickImage(ImageSource.camera);

                setState(() {
                  widget.selectedImages.add(widget.image);
                });
              },
              child: const Text(
                "Take a photo",
                style: TextStyle(fontFamily: "PoppinsSemiBold", fontSize: 15),
              ),
            ),
          ),
          SimpleDialogOption(
            child: GestureDetector(
              onTap: () async {
                Navigator.pop(context);
                widget.image = await pickImage(ImageSource.gallery);
                setState(() {
                  if (widget.image != null) {
                    widget.selectedImages.add(widget.image);
                  }
                });
              },
              child: const Text(
                "Pick a photo",
                style: TextStyle(fontFamily: "PoppinsSemiBold", fontSize: 15),
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .snapshots(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircleAvatar(
                        foregroundImage:
                            AssetImage("assets\\images\\profile_avatar.jpg"),
                      );
                    } else if (snapshot.hasError) {
                      return const CircleAvatar(
                        foregroundImage:
                            AssetImage("assets\\images\\profile_avatar.jpg"),
                      );
                    } else {
                      try {
                        final userData = snapshot.data!.data();

                        return CircleAvatar(
                          foregroundImage:
                              NetworkImage(userData!["profilePhotoUrl"]),
                        );
                      } catch (e) {
                        return const CircleAvatar(
                          foregroundImage:
                              AssetImage("assets\\images\\profile_avatar.jpg"),
                        );
                      }
                    }
                  }))),
          title: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    "@ Username",
                    style:
                        TextStyle(fontFamily: "PoppinsSemiBold", fontSize: 15),
                  );
                } else {
                  final dataFromSnap = (snapshot.data!.data());
                  final username = dataFromSnap!["username"];

                  return Text(
                    "@ $username",
                    style: const TextStyle(
                        fontFamily: "PoppinsSemiBold", fontSize: 15),
                  );
                }
              }),
          actions: [
            GestureDetector(
              onTap: () => selectImage(context),
              child: const Icon(
                Icons.image,
                color: Colors.black,
              ),
            ),
            const SizedBox(
              width: 40,
            ),
            GestureDetector(
              onTap: () async {
                var listWithImagesUrl = [];

                if (widget.selectedImages.isNotEmpty) {
                  for (var image in widget.selectedImages) {
                    listWithImagesUrl.add(await storageMethods
                        .uploadImageToStorage("posts", image, true));
                  }
                }

                final userData = await FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .get();

                Post post = Post(
                  description: postController.text,
                  postUID: uuid.v1(),
                  username: userData["username"],
                  imageUrls:
                      widget.selectedImages.isEmpty ? [] : listWithImagesUrl,
                  likes: [],
                  profileImgUrl: userData["profilePhotoUrl"],
                  publishedDateTime: DateTime.now(),
                  email: userData["email"],
                );

                final uploadPostResponse = FirebaseMethods().uploadPost(post);
                if (uploadPostResponse == true) {
                  showSnackbar(context, "Post uploaded!");
                  Navigator.pop(context);
                } else {
                  showSnackbar(context, "Failed to load post!");
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.black),
                child: const Text(
                  "Post",
                  style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 13,
                      color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: postController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Share your thoughts...",
                  hintStyle:
                      TextStyle(fontFamily: "PoppinsRegular", color: greyColor),
                ),
                cursorColor: Colors.black,
                style: const TextStyle(
                    fontFamily: "PoppinsRegular", color: Colors.black),
                minLines: 10,
                maxLines: 10,
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.selectedImages.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                        width: 100,
                        height: 100,
                        child: Image(
                            image: MemoryImage(widget.selectedImages[index])));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
