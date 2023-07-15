import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:chat_app/ui/screens/grouphome_screen.dart';
import 'package:chat_app/ui/screens/home_screen.dart';
import 'package:chat_app/ui/screens/videocall_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/global_constants.dart';
class RootScreen extends StatefulWidget {
   RootScreen({super.key, required this.index,});
  final int index;
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  late int slectedIndex = widget.index;
  late PageController pageController =
  PageController(initialPage: slectedIndex, keepPage: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:scafold_background,
      body: PageView(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        children:  [HomeScreen(), GroupChatHomeScreen(),VideocallsScreen()],
        onPageChanged: (value) {
          setState(() {
            slectedIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: lightgreen,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        curve: Curves.easeInOut,
        selectedIndex: slectedIndex,

        items: [
          BottomNavyBarItem(
              activeColor: Colors.black,
              textAlign: TextAlign.center,
             inactiveColor: Colors.white,
              icon: const Icon(
                CupertinoIcons.chat_bubble_2_fill,
              ),
              title: Text(
                "Chats",
               // style: textStyle.bodyNormal.copyWith(color: colors.primary),
              )),
          BottomNavyBarItem(
              activeColor: Colors.black,
              textAlign: TextAlign.center,
              inactiveColor: Colors.white,
              icon: const Icon(
                CupertinoIcons.group_solid,
              ),
              title: Text(
                "Groups",
              )),
          BottomNavyBarItem(
              activeColor: Colors.black,
              textAlign: TextAlign.center,
              inactiveColor: Colors.white,
              icon: const Icon(
                CupertinoIcons.video_camera_solid,
              ),
              title: Text(
                "Videos",
                // style: textStyle.bodyNormal.copyWith(color: colors.primary),
              )),

        ],
        onItemSelected: (value) {
          setState(() {
            slectedIndex = value;
            pageController.jumpToPage(slectedIndex);
          });
        },
      ),
    );
  }
}