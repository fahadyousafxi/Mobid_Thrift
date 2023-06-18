import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/firebase_Services/Splash_Service.dart';
import 'package:mobidthrift/ui/deep_linking/dynamic_link_Product_page.dart';

import '../constants/App_texts.dart';
import '../constants/App_widgets.dart';
import 'deep_linking/dynamic_link_Product_page_for_gust.dart';

class SplashScreen extends StatefulWidget {
  String? path;
  SplashScreen({Key? key, required this.path}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashService _splashService = SplashService();
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.path != null) {
      initDynamicLinks();
      WidgetsBinding.instance.addPostFrameCallback((c) => openTheProduct());
    } else {
      _splashService.isLogin(context);
    }
  }

  StreamSubscription? _dynamicLinkStreamSubscription;
  String? _link;

  String? collectionName;
  String? documentID;
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
      log('path is not null');
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => _auth.currentUser != null
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

  openTheProduct() {
    if (widget.path != null) {
      log('path is not null');
      Uri uri = Uri.parse(widget.path!);
      String collection = uri.pathSegments[0];
      String documentId = uri.pathSegments[1];
      collectionName = collection; //widget.path;
      documentID = documentId; //widget.path;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => _auth.currentUser != null
                ? DynamicLinkProductPage(
                    productDocumentId: documentID,
                    productCollectionName: collectionName,
                  )
                : DynamicLinkProductPageForGust(
                    productDocumentId: documentID,
                    productCollectionName: collectionName,
                  )),
      );
    } else {
      log('Sorry path is null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image(
              image: AssetImage("assets/images/backgroundimage.png"),
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: AppWidgets()
                .myHeading1Text(AppTexts.appName, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
