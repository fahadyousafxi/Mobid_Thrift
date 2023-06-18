import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobidthrift/chat_module/Chating/chats.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/ui/Profile_Screen.dart';
import 'package:mobidthrift/ui/login/Signup_page.dart';
import 'package:ndialog/ndialog.dart';

import '../../constants/App_colors.dart';
import '../../utils/guest_direction_to_login.dart';
import '../../utils/utils.dart';
import '../About_Us.dart';
import '../Contact_Us.dart';
import '../Search_Page.dart';
import '../Sold_Products.dart';
import '../Trade_Your_Product.dart';
import '../bottom_navigation_bar.dart';
import '../cart/cart_wish_biddings.dart';
import '../login/Login_page.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final _firebaseAuth = FirebaseAuth.instance;

  final _fireStore = FirebaseFirestore.instance.collection('users');

  final _fireStoreSnap = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();
  final _fireStoreSnapshot = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .get();

  File? pickedImage;
  bool showLocalImage = false;
  pickImageFrom(ImageSource fromGalleryOrCamera) async {
    XFile? file = await ImagePicker()
        .pickImage(source: fromGalleryOrCamera, imageQuality: 60);
    if (file == null) {
      return;
    }

    pickedImage = File(file.path);
    showLocalImage = true;
    setState(() {});
    ProgressDialog progressDialog = ProgressDialog(
      context,
      title: const Text('Uploading !!!'),
      message: const Text('Please wait'),
    );
    progressDialog.show();
    try {
      var fileName = _firebaseAuth.currentUser!.email!.toString() + '.jpg';
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child(fileName)
          .putFile(pickedImage!);
      TaskSnapshot snapshot = await uploadTask;
      String profileImageUrl = await snapshot.ref.getDownloadURL();
      print(profileImageUrl);
      _fireStore.doc(_firebaseAuth.currentUser?.uid.toString()).update({
        'Profile_Image': profileImageUrl,
      });
      progressDialog.dismiss();
      Utils.flutterToast(' Uploaded Successful ');
    } catch (e) {
      progressDialog.dismiss();
      print(e.toString());
      Utils.flutterToast(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColors.drawerColor,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(),
              child: Column(
                children: [
                  _firebaseAuth.currentUser != null
                      ? FutureBuilder<DocumentSnapshot>(
                          future: _fireStoreSnapshot,
                          builder: (BuildContext context,
                              AsyncSnapshot<DocumentSnapshot> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));

                            if (snapshot.hasError)
                              return Center(child: Text('Some Error'));

                            return Expanded(
                              child: Container(
                                  height: 85,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(22),
                                    onTap: () {
                                      bottomSheet(context);
                                    },
                                    child:
                                        // ClipRRect(
                                        //     borderRadius: BorderRadius.circular(38),
                                        //     child: showLocalImage == false
                                        //         ? Image.network(
                                        //             "https://via.placeholder.com/150")
                                        //         : Image.file(pickedImage!),
                                        //
                                        // )

                                        CircleAvatar(
                                      radius: 44,
                                      backgroundImage: showLocalImage == false
                                          ? NetworkImage(snapshot
                                                      .data!['Profile_Image'] ==
                                                  ""
                                              ? 'https://alumni.engineering.utoronto.ca/files/2022/05/Avatar-Placeholder-400x400-1.jpg'
                                              : snapshot.data!['Profile_Image'])
                                          : Image.file(pickedImage!).image,

                                      // AssetImage('assets/images/phone.png'),
                                    ),
                                  )),
                            );
                          })
                      : Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: AppWidgets().myElevatedBTN(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SignupPage()));
                                    },
                                    btnText: 'SignUp',
                                    btnColor: Colors.redAccent)),
                          ],
                        ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                    child: _firebaseAuth.currentUser != null
                        ? Text(
                            'Profile',
                            style: TextStyle(color: AppColors.drawerTextColor),
                          )
                        : SizedBox(),
                  ),
                ],
              ),
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(
                Icons.home_filled,
              ),
              title: Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CustomNavigationBar()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.stacked_line_chart),
              title: Text('Trade Your Product'),
              onTap: () {
                Navigator.pop(context);
                _firebaseAuth.currentUser != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TradeYourProduct()))
                    : GuestDirectionToLogin().guestDirectionToLogin(context);
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchPage()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.shopping_cart),
              title: Text('Cart'),
              onTap: () {
                Navigator.pop(context);
                _firebaseAuth.currentUser != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartWishBidding(
                                  iniIndex: 0,
                                )))
                    : GuestDirectionToLogin().guestDirectionToLogin(context);
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.favorite),
              title: Text('Wish List'),
              onTap: () {
                Navigator.pop(context);
                _firebaseAuth.currentUser != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartWishBidding(
                                  iniIndex: 2,
                                )))
                    : GuestDirectionToLogin().guestDirectionToLogin(context);
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.chat),
              title: Text('Chats'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Chats()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.playlist_add_check_outlined),
              title: Text('Sold Products'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SoldProducts()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.sticky_note_2_outlined),
              title: Text('About Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.phone),
              title: Text('Contact Us'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
            ListTile(
              textColor: AppColors.drawerTextColor,
              iconColor: AppColors.drawerIconColor,
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                myAlertDialog(context);
                // final _auth = FirebaseAuth.instance;
                //
                // _auth.signOut().then((value) {
                //   Navigator.pop(context);
                //   Navigator.pushReplacement(context,
                //       MaterialPageRoute(builder: (context) => LoginPage()));
                // }).onError((error, stackTrace) {
                //   Utils.flutterToast(error.toString());
                // });
              },
            ),
            Divider(
              color: AppColors.drawerDividerColor,
              height: 1,
              thickness: 2,
            ),
          ],
        ));
  }

  /// my Alert Dialog
  Future myAlertDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: AlertDialog(
              title: Text('Confirmation!!'),
              content: Text('Are You Sure to Log Out?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('No')),
                TextButton(
                  onPressed: () {
                    final _auth = FirebaseAuth.instance;
                    _auth.signOut().then((value) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }).onError((error, stackTrace) {
                      Utils.flutterToast(error.toString());
                    });
                  },
                  child: Text('Yes'),
                )
              ],
            ),
          );
        });
  }

  /// bottom Sheet
  Future bottomSheet(context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('With Camera'),
                  onTap: () {
                    pickImageFrom(ImageSource.camera);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.storage),
                  title: const Text('From Gallery'),
                  onTap: () {
                    pickImageFrom(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}
