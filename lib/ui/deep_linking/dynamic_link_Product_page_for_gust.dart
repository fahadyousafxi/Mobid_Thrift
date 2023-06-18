import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/seller_provider.dart';
import 'package:mobidthrift/ui/Seller_Profile.dart';
import 'package:mobidthrift/ui/Splash_Screen.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../utils/guest_direction_to_login.dart';
import '../cart/cart_wish_biddings.dart';

class DynamicLinkProductPageForGust extends StatefulWidget {
  String? productCollectionName;
  String? productDocumentId;
  DynamicLinkProductPageForGust(
      {required this.productDocumentId,
      required this.productCollectionName,
      Key? key})
      : super(key: key);

  @override
  State<DynamicLinkProductPageForGust> createState() =>
      _DynamicLinkProductPageForGustState();
}

class _DynamicLinkProductPageForGustState
    extends State<DynamicLinkProductPageForGust> {
  int _countTime = 0;
  int _countDownTime = 0;
  var f = NumberFormat('00', 'en_US');

  TextEditingController bidAmount = TextEditingController();
  final auth = FirebaseAuth.instance.currentUser;
  SellerProvider _sellerProvider = SellerProvider();

  var currentBid = 0;
  var myBid = 0;
  bool _validate = false;

  @override
  void dispose() {
    bidAmount.dispose();
    super.dispose();
  }

  @override
  void initState() {
    SellerProvider sellerProviders = Provider.of(context, listen: false);

    // sellerProviders.getSellerData(widget.productShopkeeperUid.toString());

    super.initState();
  }

  final _auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final _fireStoreSnapshot = FirebaseFirestore.instance;
    // _sellerProvider = Provider.of(context);
    // // _sellerProvider.getSellerData(widget.productShopkeeperUid.toString());
    //
    // cartProvider = Provider.of(context);
    // wishListProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SplashScreen(
                            path: null,
                          )));
            },
            icon: Icon(Icons.arrow_back_ios_new)),
        backgroundColor: Colors.black,
        title: const Text("MobidThrift"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _auth != null
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartWishBidding(
                                  iniIndex: 0,
                                )))
                    : GuestDirectionToLogin().guestDirectionToLogin(context);
              },
              icon: Icon(Icons.shopping_cart)),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      // drawer: MyDrawer(),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          /// *********************************************************************
          /// *********************************************************************
          /// ***************    The New Code    *********************************
          /// *********************************************************************
          /// *********************************************************************
          FutureBuilder<DocumentSnapshot>(
              future: _fireStoreSnapshot
                  .collection(widget.productCollectionName.toString())
                  .doc(widget.productDocumentId.toString())
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));

                if (snapshot.hasError) return Center(child: Text('Some Error'));

                currentBid = snapshot.data!['productCurrentBid']!.toInt();
                return snapshot.data!['productSold'] == true
                    ? Center(heightFactor: 22, child: Text('Product is sold'))
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 22,
                          ),
                          FutureBuilder<DocumentSnapshot>(
                              future: _fireStoreSnapshot
                                  .collection('SellerCenterUsers')
                                  .doc(snapshot.data!['productShopkeeperUid'])
                                  .get(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ));

                                if (snapshot.hasError)
                                  return Center(child: Text('Some Error'));

                                return Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => SellerProfile(
                                                      locationLatitude: snapshot
                                                              .data!['location_address']
                                                          ['latitude'],
                                                      locationLongitude: snapshot
                                                              .data!['location_address']
                                                          ['longitude'],
                                                      name: snapshot
                                                          .data!['Name'],
                                                      profileImage:
                                                          snapshot.data![
                                                              'Profile_Image'],
                                                      email: snapshot
                                                          .data!['Email'],
                                                      contactNo: snapshot
                                                          .data!['Phone_Number'],
                                                      reviews: double.parse(snapshot.data!['Total_Review_Rating'].toString()),
                                                      totalNoOfReviews: snapshot.data!['Total_Number_of_Reviews'],
                                                      uId: snapshot.data!['Uid'])));
                                        },
                                        child: snapshot.data!['Profile_Image']
                                                    .toString() ==
                                                ''
                                            ? CircleAvatar(
                                                radius: 33,
                                                backgroundImage: AssetImage(
                                                    'assets/images/img.png'),
                                              )
                                            : CircleAvatar(
                                                radius: 33,
                                                backgroundImage: NetworkImage(
                                                    snapshot
                                                        .data!['Profile_Image']
                                                        .toString()),
                                              ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 21,
                                          ),
                                          Container(
                                              height: 85,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  InkWell(
                                                      onTap: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SellerProfile(
                                                                          locationLatitude:
                                                                              snapshot.data!['location_address']['latitude'],
                                                                          locationLongitude:
                                                                              snapshot.data!['location_address']['longitude'],
                                                                          name:
                                                                              snapshot.data!['Name'],
                                                                          profileImage:
                                                                              snapshot.data!['Profile_Image'],
                                                                          email:
                                                                              snapshot.data!['Email'],
                                                                          contactNo:
                                                                              snapshot.data!['Phone_Number'],
                                                                          reviews:
                                                                              snapshot.data!['Total_Review_Rating'],
                                                                          totalNoOfReviews:
                                                                              snapshot.data!['Total_Number_of_Reviews'],
                                                                          uId: snapshot
                                                                              .data!['Uid'],
                                                                        )));
                                                      },
                                                      child: AppWidgets()
                                                          .myHeading1Text(
                                                              "${snapshot.data!['Name']}")),
                                                  Row(
                                                    children: [
                                                      Text('Review '),
                                                      Row(
                                                        children: List.generate(
                                                            5,
                                                            (index) => Icon(
                                                                  Icons.star,
                                                                  color: Colors
                                                                      .orange,
                                                                  size: 20,
                                                                )),
                                                      ),
                                                      Text(' (${snapshot.data!['Total_Review_Rating']}.00'
                                                                  .toString()
                                                                  .substring(
                                                                      0, 5) +
                                                              ')' ??
                                                          '')
                                                    ],
                                                  ),
                                                ],
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 260,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snapshot.data!['productImages'].length,
                              itemBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  // width: 244,
                                  child: Column(
                                    children: [
                                      Container(
                                        // width: 155,
                                        height: 255,
                                        margin:
                                            EdgeInsets.only(left: 20, right: 5),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(11),
                                          child: InteractiveViewer(
                                            panEnabled:
                                                false, // Set it to false
                                            boundaryMargin: EdgeInsets.all(100),
                                            minScale: 0.8,
                                            maxScale: 3,
                                            child: Image(
                                              // The Data will be loaded from firebse
                                              image: NetworkImage(snapshot
                                                  .data!['productImages'][index]
                                                  .toString()),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );

                                //   Container(
                                //   height: 255,
                                //   decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(333)),
                                //   child: Column(
                                //     children: [
                                //       InteractiveViewer(
                                //         panEnabled: false, // Set it to false
                                //         boundaryMargin: EdgeInsets.all(100),
                                //         minScale: 0.5,
                                //         maxScale: 2,
                                //         child: Image.network(
                                //           widget.productImage1!,
                                //           fit: BoxFit.cover,
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            snapshot.data!['productName'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 12, right: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 22, right: 22, top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      snapshot.data!['IsStartingBid'] == false
                                          ? Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text('Not On Auction'),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                    'Price: Rs.${snapshot.data!['productPrice']}')
                                              ],
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Rs.${currentBid!.toInt()} Current Bid'),
                                                myBid == 0
                                                    ? SizedBox()
                                                    : Text(
                                                        'Rs.${myBid.toInt()} your Bid'),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                countDownTimer(snapshot.data![
                                                        'BidEndTimeInSeconds']!
                                                    .toInt()),
                                              ],
                                            ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // PTA Approved condition for
                                          widget.productCollectionName ==
                                                      'CellPhonesProducts' ||
                                                  widget.productCollectionName ==
                                                      'SmartWatches' ||
                                                  widget.productCollectionName ==
                                                      'PadsAndTabletsProducts'
                                              ? Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text('PTA Approved'),
                                                    snapshot.data![
                                                                'productPTAApproved'] ==
                                                            true
                                                        ? Icon(
                                                            Icons.done_rounded,
                                                            color: Colors.green,
                                                          )
                                                        : Icon(
                                                            Icons
                                                                .cancel_rounded,
                                                            color: Colors.red,
                                                          )
                                                  ],
                                                )
                                              : SizedBox(),
                                          Text(
                                              'Shipping: Rs.${snapshot.data!['productShipping']}'),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                snapshot.data!['IsStartingBid'] == false
                                    ? SizedBox()
                                    : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            height: _validate ? 49 : 35,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.2,
                                            child: TextField(
                                              controller: bidAmount,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                  errorText: _validate
                                                      ? 'Your bid amount is low'
                                                      : null,
                                                  alignLabelWithHint: false,
                                                  border: OutlineInputBorder(
                                                      gapPadding: 113),
                                                  contentPadding:
                                                      EdgeInsets.only(
                                                          top: 4, left: 6),
                                                  // labelText: 'Label',
                                                  hintText: 'Your Bid Amount'
                                                  // height: 60, // Set the height of the text field
                                                  ),
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          AppWidgets().myElevatedBTN(
                                            btnWith: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            btnHeight: 35.0,
                                            onPressed: () async {
                                              GuestDirectionToLogin()
                                                  .guestDirectionToLogin(
                                                      context);
                                            },
                                            btnText: 'Bid',
                                            btnColor: AppColors.buttonColorBlue,
                                          )
                                        ],
                                      ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AppWidgets().myElevatedBTN(
                                        btnWith:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        btnHeight: 35.0,
                                        onPressed: () async {
                                          GuestDirectionToLogin()
                                              .guestDirectionToLogin(context);
                                        },
                                        btnText:
                                            'Buy it now: Rs.${snapshot.data!['productPrice']}',
                                        btnColor: AppColors.buttonColorBlue),
                                    AppWidgets().myElevatedBTN(
                                        btnWith:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        btnHeight: 35.0,
                                        onPressed: () {
                                          GuestDirectionToLogin()
                                              .guestDirectionToLogin(context);
                                        },
                                        btnText: '❤ Add to wish list',
                                        btnColor: AppColors.buttonColorBlue),
                                    AppWidgets()
                                        .myHeading2Text('Discription: '),
                                    AppWidgets().myNormalText(
                                        '     ${snapshot.data!['productDescription']}'),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    AppWidgets()
                                        .myHeading2Text('Specification: '),
                                    AppWidgets().myNormalText(
                                        '     ${snapshot.data!['productSpecification']}'),
                                    SizedBox(
                                      height: 5,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
              }),
        ],
      )),
    );
  }

  /// Count Down Timer
  Widget countDownTimer(var endTime) {
    // _countdownController.start();
    _countTime = endTime - (DateTime.now().millisecondsSinceEpoch ~/ 1000);
    if (_countTime > 0) {
      _countDownTime = _countTime;
    } else {
      _countDownTime = 0;
    }
    print(_countDownTime);
    return Countdown(
      // controller: _countdownController,
      seconds: _countDownTime,
      build: (BuildContext context, double time) => Text(
          '${(time ~/ 86400)}Days  ${f.format((time % 86400) ~/ 3600)}:${f.format((time % 3600) ~/ 60)}:${f.format(time.toInt() % 60)} Time Left'),
      interval: Duration(seconds: 1),
      onFinished: () {
        debugPrint('#######################  ok  #################');
      },
    );
  }
}
