import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:ndialog/ndialog.dart';

import '../utils/utils.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  bool nameEditing = false;
  final _firebaseAuth = FirebaseAuth.instance;

  final _fireStore = FirebaseFirestore.instance.collection('users');

  // final  _fireStoreSnap = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.uid).snapshots();
  final _fireStoreSnapshot = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .snapshots();

  File? pickedImage;
  bool showLocalImage = false;
  pickImageFrom(ImageSource fromGalleryOrCamera) async {
    XFile? file = await ImagePicker()
        .pickImage(source: fromGalleryOrCamera, imageQuality: 80);
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('My Profile'),
        centerTitle: true,
        // actions: [
        //
        //   IconButton(
        //       onPressed: () {
        //
        //       },
        //       icon: Icon(Icons.shopping_cart)),
        // ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<DocumentSnapshot>(
            stream: _fireStoreSnapshot,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.white,
                ));

              if (snapshot.hasError) return Center(child: Text('Some Error'));

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                          height: 150,
                          width: 150,
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
                              backgroundColor: Colors.blue,
                              radius: 70,
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
                    ),
                    SizedBox(
                      height: 11,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!['Name'].toString().toTitleCase(),
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              nameEditing = !nameEditing;
                              setState(() {});
                              // _fireStore
                              //     .doc(
                              //         _firebaseAuth.currentUser?.uid.toString())
                              //     .update({
                              //   // 'Name': profileImageUrl,
                              // });
                              // Utils.flutterToast(' Uploaded Successful ');
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.blue,
                            ))
                      ],
                    ),
                    nameEditing == false
                        ? SizedBox()
                        : Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            child: Column(
                              children: [
                                AppWidgets().myTextFormField(
                                    fillColor: Colors.grey.shade300,
                                    hintColor: Colors.grey,
                                    textColor: Colors.black,
                                    labelColor: Colors.black,
                                    borderSideColor: Colors.black,
                                    hintText: snapshot.data!['Name']
                                        .toString()
                                        .toTitleCase(),
                                    labelText: 'Name',
                                    controller: nameController),
                                SizedBox(
                                  height: 10,
                                ),
                                AppWidgets().myElevatedBTN(
                                    onPressed: () async {
                                      if (nameController.text.isNotEmpty) {
                                        await _firebaseAuth.currentUser
                                            ?.updateDisplayName(nameController
                                                .text
                                                .toString()
                                                .trim());
                                        await _fireStore
                                            .doc(_firebaseAuth.currentUser?.uid
                                                .toString())
                                            .update({
                                          'Name': nameController.text
                                              .toString()
                                              .trim(),
                                        }).then((value) {
                                          Utils.flutterToast(
                                              ' Uploaded Successful ');
                                        }).onError((error, stackTrace) {
                                          Utils.flutterToast(
                                              ' ${error.toString()} ');
                                        });
                                      } else {
                                        Utils.flutterToast(
                                            ' Please enter your name ');
                                      }
                                    },
                                    btnText: "Submit",
                                    btnColor: Colors.blue)
                              ],
                            ),
                          ),
                    SizedBox(
                      height: 11,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(11.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Email:  ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data!['Email'])
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Phone Number:  ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data!['Phone_Number']),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Address:  ',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(snapshot.data!['Address'])
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
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

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
