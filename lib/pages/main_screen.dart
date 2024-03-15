// ignore_for_file: avoid_unnecessary_containers

import "package:flutter/material.dart";
import "package:google_nav_bar/google_nav_bar.dart";
import "package:material_design_icons_flutter/material_design_icons_flutter.dart";
import "package:vtag/pages/account_screen.dart";
import "package:vtag/pages/home_screen.dart";
import "package:vtag/resources/colors.dart";

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(),
    Container(
      child: const Center(
        child: Text("Network"),
      ),
    ),
    Container(
      child: const Center(
        child: Text("Jobs"),
      ),
    ),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: GNav(
            backgroundColor: Colors.white,
            onTabChange: (index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            gap: 10,
            tabs: [
              GButton(
                icon: MdiIcons.home,
                iconActiveColor: blueColor,
                iconColor: lightBlueColor,
                textColor: blueColor,
                text: "Home",
              ),
              const GButton(
                icon: Icons.group,
                iconActiveColor: blueColor,
                iconColor: lightBlueColor,
                textColor: blueColor,
                text: "Network",
              ),
              const GButton(
                icon: Icons.work,
                iconActiveColor: blueColor,
                iconColor: lightBlueColor,
                textColor: blueColor,
                text: "Jobs",
              ),
              GButton(
                icon: MdiIcons.account,
                iconActiveColor: blueColor,
                iconColor: lightBlueColor,
                textColor: blueColor,
                text: "Profile",
              ),
            ]),
        body: pages[currentPageIndex],
      ),
    );
  }
}