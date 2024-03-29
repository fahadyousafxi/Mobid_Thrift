import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/providers/Wish_List_Provider.dart';
import 'package:mobidthrift/providers/seller_provider.dart';
import 'package:mobidthrift/ui/Seller_Profile.dart';
import 'package:mobidthrift/utils/utils.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../Splash_Screen.dart';
import '../cart/cart_wish_biddings.dart';

class DynamicLinkProductPage extends StatefulWidget {
  // String? productImage1;
  // String? productImage2;
  // String? productImage3;
  // String? productImage4;
  // String? productImage5;
  // String? productImage6;
  String? productCollectionName;
  String? productDocumentId;
  bool? backToSplash;
  // String? productName;
  // String? productDescription;
  // String? productSpecification;
  // String? productUid;
  // String? productShopkeeperUid;
  // int? productCurrentBid;
  // int? productShipping;
  // int? bidEndTimeInSeconds;
  // int? productPrice;
  // DateTime? productDateTime;
  // DateTime? bidDateTimeLeft;
  // bool? productPTAApproved;
  // bool? isStartingBid;
  DynamicLinkProductPage(
      { // this.productImage1,
      // this.productImage2,
      // this.isStartingBid,
      // this.bidEndTimeInSeconds,
      // this.productImage3,
      // this.productImage4,
      // this.productImage5,
      // this.productImage6,
      required this.productDocumentId,
      required this.productCollectionName,
      this.backToSplash,
      // this.productName,
      // this.productDescription,
      // this.productSpecification,
      // this.productUid,
      // required this.productShopkeeperUid,
      // this.productCurrentBid,
      // this.productShipping,
      // this.productPrice,
      // this.productDateTime,
      // this.bidDateTimeLeft,
      // this.productPTAApproved,
      Key? key})
      : super(key: key);

  @override
  State<DynamicLinkProductPage> createState() => _DynamicLinkProductPageState();
}

class _DynamicLinkProductPageState extends State<DynamicLinkProductPage> {
  int _countTime = 0;
  int _countDownTime = 0;
  var f = NumberFormat('00', 'en_US');

  TextEditingController bidAmount = TextEditingController();
  final auth = FirebaseAuth.instance.currentUser;

  CartProvider cartProvider = CartProvider();
  WishListProvider wishListProvider = WishListProvider();
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
            onPressed: widget.backToSplash == false
                ? () {
                    Navigator.pop(context);
                  }
                : () {
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartWishBidding(
                              iniIndex: 0,
                            )));
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
                                              int bid = int.parse(
                                                  bidAmount.text.toString());
                                              print(bid);
                                              if (_countDownTime == 0) {
                                                Utils.flutterToast(
                                                    'Bidding Time Up');
                                                return;
                                              }
                                              if (bid > 9999999) {
                                                Utils.flutterToast(
                                                    'Your Bid Amount is too high');
                                                return;
                                              }
                                              if (bid > currentBid!) {
                                                // bidAmount.text.isEmpty || bid < currentBid ? _validate = true : _validate = false;
                                                _validate = false;
                                                myBid = bid;
                                                currentBid = bid;

                                                ProgressDialog progressDialog2 =
                                                    ProgressDialog(
                                                  context,
                                                  title: const Text(
                                                      'Creating Your Bid !!!'),
                                                  message:
                                                      const Text('Please wait'),
                                                );
                                                setState(() {});
                                                progressDialog2.show();
                                                try {
                                                  cartProvider
                                                      .addYourBiddingData(
                                                    cartPrice: snapshot
                                                        .data!['productPrice'],
                                                    cartShopkeeperUid: snapshot
                                                            .data![
                                                        'productShopkeeperUid'],
                                                    cartImage1: snapshot
                                                        .data!['productImage1'],
                                                    cartDescription: snapshot
                                                            .data![
                                                        'productDescription'],
                                                    cartPTAApproved: snapshot
                                                            .data![
                                                        'productPTAApproved'],
                                                    cartName: snapshot
                                                        .data!['productName'],
                                                    cartCurrentBid: currentBid,
                                                    cartUid: snapshot
                                                        .data!['productUid'],
                                                  );
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(widget
                                                          .productCollectionName
                                                          .toString())
                                                      .doc(snapshot
                                                          .data!['productUid']
                                                          .toString())
                                                      .update({
                                                    "productCurrentBid":
                                                        currentBid,
                                                    "higherBidder": FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid
                                                        .toString()
                                                  }).then((value) {
                                                    progressDialog2.dismiss();
                                                    Utils.flutterToast(
                                                        'Your Bid is Created!');
                                                  });
                                                } catch (e) {
                                                  progressDialog2.dismiss();
                                                  Utils.flutterToast(
                                                      e.toString());
                                                }

                                                setState(() {});
                                              } else {
                                                bidAmount.text.isEmpty ||
                                                        bid <= currentBid!
                                                    ? _validate = true
                                                    : _validate = false;
                                                setState(() {});
                                              }
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
                                          ProgressDialog progressDialog2 =
                                              ProgressDialog(
                                            context,
                                            title:
                                                const Text('Product Buying!!!'),
                                            message: const Text('Please wait'),
                                          );
                                          setState(() {});
                                          progressDialog2.show();
                                          cartProvider.addCartData(
                                            cartPrice:
                                                snapshot.data!['productPrice'],
                                            cartShopkeeperUid: snapshot
                                                .data!['productShopkeeperUid'],
                                            cartImage1:
                                                snapshot.data!['productImage1'],
                                            cartDescription: snapshot
                                                .data!['productDescription'],
                                            cartPTAApproved: snapshot
                                                .data!['productPTAApproved'],
                                            cartName:
                                                snapshot.data!['productName'],
                                            cartCurrentBid: currentBid,
                                            cartUid:
                                                snapshot.data!['productUid'],
                                            cartCollectionName:
                                                widget.productCollectionName,
                                            cartSpecification: snapshot
                                                .data!['productSpecification'],
                                            cartShipping: snapshot
                                                .data!['productShipping'],
                                          );
                                          await FirebaseFirestore.instance
                                              .collection(widget
                                                  .productCollectionName
                                                  .toString())
                                              .doc(snapshot.data!['productUid']
                                                  .toString())
                                              .update({
                                            // "productSold": true,
                                            // "productBuyer": FirebaseAuth
                                            //     .instance.currentUser!.uid
                                            //     .toString()
                                            "addedToCart": true
                                          }).then((value) {
                                            progressDialog2.dismiss();
                                            Utils.flutterToast(
                                                'Added to Cart!!');
                                          }).onError((error, stackTrace) {
                                            progressDialog2.dismiss();
                                            Utils.flutterToast(
                                                error.toString());
                                          });
                                        },
                                        btnText:
                                            'Buy it now: Rs.${snapshot.data!['productPrice']}',
                                        btnColor: AppColors.buttonColorBlue),
                                    AppWidgets().myElevatedBTN(
                                        btnWith:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        btnHeight: 35.0,
                                        onPressed: () async {
                                          try {
                                            cartProvider.addWishListData(
                                              cartPrice: snapshot
                                                  .data!['productPrice'],
                                              cartShopkeeperUid: snapshot.data![
                                                  'productShopkeeperUid'],
                                              cartImage1: snapshot
                                                  .data!['productImage1'],
                                              cartDescription: snapshot
                                                  .data!['productDescription'],
                                              cartPTAApproved: snapshot
                                                  .data!['productPTAApproved'],
                                              cartName:
                                                  snapshot.data!['productName'],
                                              cartCurrentBid: currentBid,
                                              cartUid:
                                                  snapshot.data!['productUid'],
                                              cartCollectionName:
                                                  widget.productCollectionName,
                                            );
                                            Utils.flutterToast(
                                                'Added to Your WishList');
                                          } catch (e) {
                                            Utils.flutterToast(e.toString());
                                          }
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
