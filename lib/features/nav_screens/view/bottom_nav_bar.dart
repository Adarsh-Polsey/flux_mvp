import 'package:flutter/material.dart';
import 'package:flux_mvp/core/app_pallete.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int navIndex = 0;
  @override

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GNav(
          activeColor: Pallete.greenColor,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          gap: 5,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          tabMargin: const EdgeInsets.symmetric(vertical: 4),
          tabBackgroundColor: Pallete.greenColor.withOpacity(0.1),
          onTabChange: (index) {
            setState(() {
              navIndex = index;
            });
          },
          selectedIndex: navIndex,
          tabs: const [
            GButton(
              icon: Icons.home,
              text: "Home",
            ),
            GButton(
              icon: Icons.person_2_outlined,
              text: "Profile",
            ),
          ]),
    ));
  }
}
