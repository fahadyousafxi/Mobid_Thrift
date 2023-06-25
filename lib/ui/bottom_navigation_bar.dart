import 'dart:async';
import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/ui/shipping/main_page.dart';

import '../Chating/chats.dart';
import 'My_Home_Page.dart';
import 'deep_linking/dynamic_link_Product_page.dart';
import 'deep_linking/dynamic_link_Product_page_for_gust.dart';

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  StreamSubscription? _dynamicLinkStreamSubscription;
  String? _link;
  final _auth2 = FirebaseAuth.instance;
  String? collectionName;
  String? documentID;

  @override
  void initState() {
    // TODO: implement initState
    initDynamicLinks();
    super.initState();
  }

  @override
  void dispose() {
    _dynamicLinkStreamSubscription?.cancel();
    super.dispose();
  }

  Future<void> initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink.listen(
      (PendingDynamicLinkData dynamicLinkData) {
        _handleLinkData(dynamicLinkData);
      },
      onError: (error) {
        print('Error handling dynamic link: $error');
      },
    );

    final PendingDynamicLinkData? initialLinkData =
        await FirebaseDynamicLinks.instance.getInitialLink();
    if (initialLinkData != null) {
      _handleLinkData(initialLinkData!);
    }
  }

  void _handleLinkData(PendingDynamicLinkData data) {
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      setState(() {
        _link = deepLink.path;
      });
      Uri uri = Uri.parse(_link!);
      String collection = uri.pathSegments[0];
      String documentId = uri.pathSegments[1];
      collectionName = collection; //widget.path;
      documentID = documentId;

      // Navigating to the appropriate page based on the dynamic link
      // if (_link!.contains('/collection')) {
      if (collectionName != null) {
        log('path is not null');
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => _auth2.currentUser != null
                  ? DynamicLinkProductPage(
                      productDocumentId: documentID,
                      productCollectionName: collectionName,
                    )
                  : DynamicLinkProductPageForGust(
                      productDocumentId: documentID,
                      productCollectionName: collectionName,
                    )),
        );
      }
    } else {
      log(' Sorry _handleLinkData path is null');
    }
  }

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
