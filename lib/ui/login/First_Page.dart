import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/ui/login/Login_page.dart';
import 'package:mobidthrift/ui/login/Signup_page.dart';

import '../../constants/App_texts.dart';
import '../../constants/App_widgets.dart';
import '../bottom_navigation_bar.dart';
import '../deep_linking/dynamic_link_Product_page.dart';
import '../deep_linking/dynamic_link_Product_page_for_gust.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  StreamSubscription? _dynamicLinkStreamSubscription;
  String? _link;
  final _auth = FirebaseAuth.instance;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "${AppTexts.appName}",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      extendBodyBehindAppBar: true,
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
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 33,
                  ),

                  SizedBox(
                    height: 33,
                  ),
                  AppWidgets().myElevatedBTN(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CustomNavigationBar()));
                      },
                      btnText: 'Continue without Login'),

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pushReplacement(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => MyHomePage()));
                  //   },
                  //   child: Text('Continue without Login'),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: AppColors.elevatedButtonColor,
                  //     minimumSize: Size(200, 40),
                  //   ),
                  // ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    child: Text('Login'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.elevatedButtonColor,
                      minimumSize: Size(200, 40),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupPage()));
                    },
                    child: Text('SignUp'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.elevatedButtonColor,
                      minimumSize: Size(200, 40),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
