import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/chat_module/Chating/chats.dart';
import 'package:mobidthrift/ui/shipping/main_page.dart';

import 'My_Home_Page.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  final _auth = FirebaseAuth.instance.currentUser?.uid;

  List pages = [
    const Chats(),
    const MyHomePage(),
    MainPage()
    // ShippingTabBar(iniIndex: 0)
  ];
  List pages2 = [
    const Center(child: Text('Please Login')),
    const MyHomePage(),
    Center(child: Text('Please Login'))
    // ShippingTabBar(iniIndex: 0)
  ];
  int currentIndex = 1;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // gradient: CustomColor().mainTheme,
          ),
      child: Scaffold(
        backgroundColor: Colors.grey,
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.grey.shade300,
          index: currentIndex,
          animationDuration: const Duration(milliseconds: 300),
          onTap: onTap,
          items: [
            Icon(
              Icons.chat_outlined,
              color: Colors.black,
            ),
            Icon(
              Icons.home_outlined,
              color: Colors.black,
              size: 40,
            ),
            Icon(
              Icons.local_shipping_outlined,
              color: Colors.black,
            ),
          ],
        ),
        body: _auth != null ? pages[currentIndex] : pages2[currentIndex],
      ),
    );
  }
}
