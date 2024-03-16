import "dart:ui";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:vtag/components/post_component.dart";
import "package:vtag/pages/post_screen.dart";
import "package:vtag/pages/setting_screens.dart";
import "package:vtag/resources/colors.dart";

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => PostScreen()));
        },
        backgroundColor: blueColor,
        foregroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
        ),
        child: const Icon(Icons.add),
      ),
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 100,
        flexibleSpace: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              height: 100,
              color: Colors.transparent,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CircleAvatar(
                      minRadius: 20,
                      foregroundImage:
                          AssetImage("assets\\images\\profile_yellow.jpg"),
                    ),
                    const Image(
                        width: 25,
                        height: 25,
                        image: NetworkImage(
                            "https://imgs.search.brave.com/JSCTdx5RmCcveSa-5gF69eVlcSf-4pr9WuYI_fLZqlE/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9mcmVl/bG9nb3BuZy5jb20v/aW1hZ2VzL2FsbF9p/bWcvMTY5MDY0Mzc3/N3R3aXR0ZXIteCUy/MGxvZ28tcG5nLXdo/aXRlLnBuZw")),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SettingsScreen()));
                        },
                        icon: const Icon(Icons.settings,
                            color: Colors.white, size: 23)),
                  ],
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black.withAlpha(200),
        elevation: 0,
      ),
      body: Padding(
          padding: const EdgeInsets.all(15),
          child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("posts").snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: Colors.white,
                  );
                } else if (snapshot.hasError) {
                  return const CircularProgressIndicator(
                    color: Colors.red,
                  );
                } else {
                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                      itemCount: docs.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            PostComponent(
                              snap: docs[index],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            const Divider(
                              thickness: 0.7,
                              color: greyColor,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        );
                      });
                }
              }))),
    );
  }
}
