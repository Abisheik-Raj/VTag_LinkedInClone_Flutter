import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:vtag/pages/account_screen.dart';
import 'package:vtag/pages/home_screen.dart';
import 'package:vtag/pages/network_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentPageIndex = 0;

  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        bottomNavigationBar: GNav(
          backgroundColor: Colors.transparent,
          onTabChange: (index) {
            setState(() {
              currentPageIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 500),
                curve: Curves.ease,
              );
            });
          },
          curve: Curves.easeInCubic,
          gap: 8,
          tabs: [
            GButton(
              icon: MdiIcons.home,
              iconActiveColor: Colors.white,
              iconColor: Colors.white,
              textColor: Colors.white,
              text: "Home",
            ),
            const GButton(
              icon: Icons.group,
              iconActiveColor: Colors.white,
              iconColor: Colors.white,
              textColor: Colors.white,
              text: "Network",
            ),
            const GButton(
              icon: Icons.work,
              iconActiveColor: Colors.white,
              iconColor: Colors.white,
              textColor: Colors.white,
              text: "Jobs",
            ),
            GButton(
              icon: MdiIcons.account,
              iconActiveColor: Colors.white,
              iconColor: Colors.white,
              textColor: Colors.white,
              text: "Profile",
            ),
          ],
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          children: [
            const HomeScreen(),
            NetworkScreen(), // Initialize NetworkScreen here
            Container(
              child: const Center(
                child: Text("Jobs"),
              ),
            ),
            const AccountScreen(),
          ],
        ),
      ),
    );
  }
}
