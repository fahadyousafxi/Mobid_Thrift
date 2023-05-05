import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobidthrift/chat_module/Chating/chat_room.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/ui/Extra_Pages/sellers_reviews_page.dart';
import 'package:mobidthrift/ui/Seller_Shop_Products.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:mobidthrift/utils/utils.dart';
import 'package:ndialog/ndialog.dart';

import '../constants/App_widgets.dart';
import '../utils/guest_direction_to_login.dart';

class SellerProfile extends StatefulWidget {
  String? contactNo;
  String? email;
  String? name;
  double? reviews;
  dynamic locationLatitude;
  dynamic locationLongitude;
  int? totalNoOfReviews;
  String? profileImage;
  String? uId;
  SellerProfile(
      {required this.name,
      required this.profileImage,
      required this.uId,
      required this.email,
      required this.contactNo,
      required this.reviews,
      required this.totalNoOfReviews,
      required this.locationLatitude,
      required this.locationLongitude,
      Key? key})
      : super(key: key);

  @override
  State<SellerProfile> createState() => _SellerProfileState();
}

class _SellerProfileState extends State<SellerProfile> {
  // SellerProvider sellerProvider = SellerProvider();

  GoogleMapController? _mapController;

  final _auth = FirebaseAuth.instance.currentUser;
  final _fireStoreInstance = FirebaseFirestore.instance;
  List<dynamic> followers = [];

  late bool uidExists;
  bool loading = false;

  String chatRoomId(String user1Uid, String user2Uid) {
    if (user1Uid[0].toLowerCase().codeUnits[0] >
        user2Uid[0].toLowerCase().codeUnits[0]) {
      return '${user1Uid.toString().substring(0, 6)}${user2Uid.toString().substring(0, 6)}';
    }
    // else if (user1Uid[0].toLowerCase().codeUnits[0] ==
    //     user2Uid[0].toLowerCase().codeUnits[0]) {
    //   return '${user1Uid.toString().substring(0, 6)}${user2Uid.toString().substring(0, 6)}equal';
    // }
    else {
      return '${user2Uid.toString().substring(0, 6)}${user1Uid.toString().substring(0, 6)}';
    }
  }

  @override
  void initState() {
    // SellerProvider sellerProvider = Provider.of(context, listen: false);
    // sellerProvider.getSellerReviewsData(widget.uId.toString());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // sellerProvider = Provider.of(context);
    // sellerProvider.getSellerReviewsData(widget.uId.toString());
    var currentLocation =
        LatLng(widget.locationLatitude, widget.locationLongitude);
    var size = MediaQuery.of(context).size;
    // sellerProvider.getSellerReviewsDataList;
    return Scaffold(
      appBar: MyAppbar().mySimpleAppBar(context, title: 'MobidThrift'),
      floatingActionButton: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 50,
          child: IconButton(
              onPressed: () async {
                String roomId = chatRoomId(_auth!.uid, widget.uId.toString());
                _fireStoreInstance
                    .collection('users')
                    .doc(_auth!.uid)
                    .collection('ChatUsers')
                    .doc(roomId)
                    .set({
                  'buyerName': _auth?.displayName.toString(),
                  'sellerName': widget.name,
                  'sellerUid': widget.uId,
                  'buyerUid': _auth?.uid,
                  'buyerPhoto': _auth?.photoURL,
                  'sellerPhoto': '${widget.profileImage}',
                  'roomUId': roomId,
                  'userEmail': _auth?.email,
                  'sellerEmail': widget.email
                });
                _fireStoreInstance.collection('ChatRoom').doc(roomId).set({
                  'buyerName': _auth?.displayName.toString(),
                  'sellerName': widget.name,
                  'sellerUid': widget.uId,
                  'buyerUid': _auth?.uid,
                  'buyerPhoto': _auth?.photoURL,
                  'sellerPhoto': '${widget.profileImage}',
                  'userEmail': _auth?.email,
                  'sellerEmail': widget.email
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatRoom(
                      chatRoomId: roomId,
                      sellerEmail: widget.email,
                      sellerName: widget.name, sellerUid: widget.uId,
                      sellerPhoto: '${widget.profileImage}',
                      // name: widget.name,
                      // uId: widget.uId,
                      // key: widget.key,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.chat,
                size: 35,
                color: AppColors.myIconColor,
              ))),
      body: SizedBox(
        height: size.height / 1,
        width: size.width / 1,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<DocumentSnapshot>(
                  future: _fireStoreInstance
                      .collection('SellerCenterUsers')
                      .doc(widget.uId)
                      .get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.blue,
                      ));
                    }

                    if (snapshot.hasError) {
                      return const Center(child: Text('Some Error'));
                    }

                    if (snapshot.hasData) {
                      followers = snapshot.data?['Followers'];
                      if (_auth != null) {
                        uidExists = followers
                            .where((item) => item.contains(_auth!.uid))
                            .isEmpty;
                        // setState(() {});
                      }
                      // .isNotEmpty;
                      return Column(
                        children: [
                          const SizedBox(height: 15),
                          widget.profileImage == ''
                              ? const CircleAvatar(
                                  radius: 44,
                                  backgroundImage:
                                      AssetImage('assets/images/img.png'))
                              : CircleAvatar(
                                  radius: 44,
                                  backgroundImage:
                                      NetworkImage(widget.profileImage!),
                                ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AppWidgets().myHeading1Text("${widget.name}"),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ReviewPage(
                                    //             reviews: widget.reviews,
                                    //             totalNoOfReviews:
                                    //                 widget.totalNoOfReviews,
                                    //             sellerUid: widget.uId)));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text('Review '),
                                      Row(
                                        children: List.generate(
                                            5,
                                            (index) => const Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 20,
                                                )),
                                      ),
                                      Text(
                                          '${' (${snapshot.data!['Total_Review_Rating']}.000'.toString().substring(0, 5)})'),
                                    ],
                                  ),
                                ),
                                _auth?.uid != null
                                    ? AppWidgets().myElevatedBTN(
                                        loading: loading,
                                        onPressed: () async {
                                          if (_auth?.uid != null) {
                                            // uidExists = await followers
                                            //     .where((item) =>
                                            //         item.contains(_auth!.uid))
                                            //     .isEmpty;
                                            followers
                                                .add(_auth!.uid.toString());
                                            // print(followers.length);
                                            List newFollower = followers;
                                            setState(() {
                                              loading = true;
                                            });
                                            ProgressDialog progressDialog =
                                                ProgressDialog(
                                              context,
                                              title: const Text('Following!!!'),
                                              message:
                                                  const Text('Please wait'),
                                            );

                                            setState(() {
                                              progressDialog.show();
                                            });
                                            _fireStoreInstance
                                                .collection('SellerCenterUsers')
                                                .doc(widget.uId)
                                                .collection('Followers')
                                                .doc(_auth!.uid.toString())
                                                .set({
                                              'FollowerUid':
                                                  _auth!.uid.toString(),
                                            }).then((value) {
                                              _fireStoreInstance
                                                  .collection(
                                                      'SellerCenterUsers')
                                                  .doc(widget.uId)
                                                  .update({
                                                'Followers': newFollower
                                              }).then((value) {
                                                _fireStoreInstance
                                                    .collection('users')
                                                    .doc(_auth!.uid)
                                                    .collection('Followings')
                                                    .doc(widget.uId.toString())
                                                    .set({
                                                  'Following':
                                                      widget.uId.toString()
                                                });
                                              });
                                              setState(() {
                                                loading = false;
                                                progressDialog.dismiss();
                                              });
                                            }).onError((error, stackTrace) {
                                              setState(() {
                                                loading = false;
                                                progressDialog.dismiss();
                                              });
                                              Utils.flutterToast(
                                                  error.toString());
                                            });
                                          }
                                        },
                                        btnText: uidExists == true
                                            ? "Follow"
                                            : 'Following',
                                        btnColor: uidExists == true
                                            ? Colors.blue
                                            : Colors.grey,
                                        btnHeight: 30.0)
                                    : AppWidgets().myElevatedBTN(
                                        onPressed: () {
                                          GuestDirectionToLogin()
                                              .guestDirectionToLogin(context);
                                        },
                                        btnText: 'Follow'),
                                const SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppWidgets().myHeading2Text(
                                        'Phone:    ${widget.contactNo}'),
                                    AppWidgets().myHeading2Text(
                                        'Email:    ${widget.email}'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.location_on_outlined,
                                      color: Colors.red,
                                    ),
                                    AppWidgets().myHeading2Text('Location'),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                    height: 200,
                                    width:
                                        MediaQuery.of(context).size.width / 1.3,
                                    child: GoogleMap(
                                      zoomGesturesEnabled: false,
                                      zoomControlsEnabled: false,
                                      markers: {
                                        Marker(
                                          markerId:
                                              const MarkerId('LocationId'),
                                          position: currentLocation,
                                          icon: BitmapDescriptor
                                              .defaultMarkerWithHue(
                                                  BitmapDescriptor.hueRed),
                                          infoWindow: InfoWindow(
                                              title: '${widget.name} Location'),
                                        ),
                                      },
                                      initialCameraPosition: CameraPosition(
                                        target: currentLocation,
                                        zoom: 14,
                                      ),
                                      onMapCreated: ((controller) {
                                        _mapController = controller;
                                      }),
                                    )),
                                const SizedBox(
                                  height: 22,
                                ),
                                AppWidgets().myElevatedBTN(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SellerShopProducts(
                                                    sellerUid:
                                                        widget.uId.toString(),
                                                    shopKeeperName: widget.name,
                                                  )));
                                    },
                                    btnText: "View Shop Products",
                                    btnColor: Colors.blue,
                                    btnHeight: 30.0),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                    return const Text('There is Some Problem');
                  }),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: const [
                    Text(
                      'Reviews',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 25.0, right: 25, bottom: 15),
              //   child: SizedBox(
              //     child: ListView.builder(
              //       shrinkWrap: true,
              //       itemCount: sellerProvider.getSellerReviewsDataList.length,
              //       itemBuilder: (BuildContext context, int index) {
              //         var data = sellerProvider.getSellerReviewsDataList[index];
              //         return Column(
              //           children: [
              //             Container(
              //               // height: 111,
              //               width: double.infinity,
              //               decoration: BoxDecoration(
              //                 color: Colors.grey.shade200,
              //                 borderRadius: BorderRadius.circular(22),
              //                 border: Border.all(
              //                   color: Colors.black,
              //                 ),
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.grey.withOpacity(0.5),
              //                     spreadRadius: 5,
              //                     blurRadius: 7,
              //                     offset:
              //                         Offset(0, 3), // changes position of shadow
              //                   ),
              //                 ],
              //               ),
              //               child: Column(
              //                 children: [
              //                   SizedBox(
              //                     height: 5,
              //                   ),
              //                   Row(
              //                     children: [
              //                       Text(
              //                         '    Name: ' + data.name.toString(),
              //                         style: TextStyle(
              //                             fontSize: 18,
              //                             fontWeight: FontWeight.bold),
              //                       )
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     height: 15,
              //                   ),
              //                   Row(
              //                     mainAxisAlignment: MainAxisAlignment.center,
              //                     children: [
              //                       Row(
              //                         children: List.generate(
              //                             data.reviewRating!,
              //                             (index) => const Icon(
              //                                   Icons.star,
              //                                   color: Colors.orange,
              //                                   size: 20,
              //                                 )),
              //                       ),
              //                       Row(
              //                         children: List.generate(
              //                             5 - data.reviewRating!,
              //                             (index) => const Icon(
              //                                   Icons.star,
              //                                   color: Colors.grey,
              //                                   size: 20,
              //                                 )),
              //                       ),
              //                       Text(
              //                         '(${data.reviewRating})',
              //                         style: TextStyle(
              //                             fontSize: 18,
              //                             fontWeight: FontWeight.bold),
              //                       )
              //                     ],
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Text(
              //                       '${data.review}',
              //                       style: TextStyle(fontSize: 18),
              //                     ),
              //                   ),
              //                   SizedBox(
              //                     height: 8,
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             SizedBox(
              //               height: 20,
              //             )
              //           ],
              //         );
              //       },
              //     ),
              //   ),
              // ),
              SizedBox(
                  // height: 411,
                  // width: size.width / 2,
                  child: SellersReviewPage(uId: widget.uId)),
              Container(
                height: 44,
              )
            ],
          ),
        ),
      ),
    );
  }
}
