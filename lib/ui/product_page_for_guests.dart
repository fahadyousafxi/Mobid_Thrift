import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/seller_provider.dart';
import 'package:mobidthrift/ui/Seller_Profile.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../utils/guest_direction_to_login.dart';

class ProductPageForGuests extends StatefulWidget {
  String? productImage1;
  String? productImage2;
  String? productImage3;
  String? productImage4;
  String? productImage5;
  String? productImage6;
  String? productCollectionName;
  String? productName;
  String? productDescription;
  String? productSpecification;
  String? productUid;
  String? productShopkeeperUid;
  int? productCurrentBid;
  int? productShipping;
  int? bidEndTimeInSeconds;
  int? productPrice;
  DateTime? productDateTime;
  DateTime? bidDateTimeLeft;
  bool? productPTAApproved;
  bool? isStartingBid;
  ProductPageForGuests(
      {this.productImage1,
      this.productImage2,
      required this.isStartingBid,
      required this.bidEndTimeInSeconds,
      this.productImage3,
      this.productImage4,
      this.productImage5,
      this.productImage6,
      this.productCollectionName,
      this.productName,
      this.productDescription,
      this.productSpecification,
      this.productUid,
      this.productShopkeeperUid,
      this.productCurrentBid,
      this.productShipping,
      this.productPrice,
      this.productDateTime,
      this.bidDateTimeLeft,
      this.productPTAApproved,
      Key? key})
      : super(key: key);

  @override
  State<ProductPageForGuests> createState() => _ProductPageForGuestsState();
}

class _ProductPageForGuestsState extends State<ProductPageForGuests> {
  // CountdownController _countdownController = CountdownController();
  int _countTime = 0;
  int _countDownTime = 0;
  var f = NumberFormat('00', 'en_US');

  final auth = FirebaseAuth.instance.currentUser;

  SellerProvider _sellerProvider = SellerProvider();

  @override
  void dispose() {
    _countTime = 0;
    _countDownTime = 0;
    super.dispose();
  }

  @override
  void initState() {
    SellerProvider sellerProviders = Provider.of(context, listen: false);

    sellerProviders.getSellerData(widget.productShopkeeperUid.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _fireStoreSnapshot = FirebaseFirestore.instance
        .collection('SellerCenterUsers')
        .doc(widget.productShopkeeperUid)
        .get();
    _sellerProvider = Provider.of(context);
    // currentBid = widget.productCurrentBid!.toInt();
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      // drawer: MyDrawer(),
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 22,
          ),
          FutureBuilder<DocumentSnapshot>(
              future: _fireStoreSnapshot,
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.blue,
                  ));

                if (snapshot.hasError) return Center(child: Text('Some Error'));

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
                                      locationLatitude:
                                          snapshot.data!['location_address']
                                              ['latitude'],
                                      locationLongitude:
                                          snapshot.data!['location_address']
                                              ['longitude'],
                                      name: snapshot.data!['Name'],
                                      profileImage:
                                          snapshot.data!['Profile_Image'],
                                      email: snapshot.data!['Email'],
                                      contactNo: snapshot.data!['Phone_Number'],
                                      reviews: double.parse(snapshot
                                          .data!['Total_Review_Rating']
                                          .toString()),
                                      totalNoOfReviews: snapshot
                                          .data!['Total_Number_of_Reviews'],
                                      uId: snapshot.data!['Uid'])));
                        },
                        child: snapshot.data!['Profile_Image'].toString() == ''
                            ? CircleAvatar(
                                radius: 33,
                                backgroundImage:
                                    AssetImage('assets/images/img.png'),
                              )
                            : CircleAvatar(
                                radius: 33,
                                backgroundImage: NetworkImage(
                                    snapshot.data!['Profile_Image'].toString()),
                              ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 21,
                          ),
                          Container(
                              height: 85,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SellerProfile(
                                                      locationLatitude: snapshot
                                                                  .data![
                                                              'location_address']
                                                          ['latitude'],
                                                      locationLongitude: snapshot
                                                                  .data![
                                                              'location_address']
                                                          ['longitude'],
                                                      name: snapshot
                                                          .data!['Name'],
                                                      profileImage:
                                                          snapshot.data![
                                                              'Profile_Image'],
                                                      email: snapshot
                                                          .data!['Email'],
                                                      contactNo: snapshot.data![
                                                          'Phone_Number'],
                                                      reviews: snapshot.data![
                                                          'Total_Review_Rating'],
                                                      totalNoOfReviews: snapshot
                                                              .data![
                                                          'Total_Number_of_Reviews'],
                                                      uId:
                                                          snapshot.data!['Uid'],
                                                    )));
                                      },
                                      child: AppWidgets().myHeading1Text(
                                          "${snapshot.data!['Name']}")),
                                  Row(
                                    children: [
                                      Text('Review '),
                                      Row(
                                        children: List.generate(
                                            5,
                                            (index) => Icon(
                                                  Icons.star,
                                                  color: Colors.orange,
                                                  size: 20,
                                                )),
                                      ),
                                      Text(
                                          ' (${snapshot.data!['Total_Review_Rating']}.00'
                                                      .toString()
                                                      .substring(0, 5) +
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
          Container(
            child: Column(
              children: [
                InteractiveViewer(
                  panEnabled: false, // Set it to false
                  boundaryMargin: EdgeInsets.all(100),
                  minScale: 0.5,
                  maxScale: 2,
                  child: Image.network(
                    widget.productImage1!,
                    height: 255,
                  ),
                ),
                Text(
                  widget.productName!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.isStartingBid == false
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Not On Auction'),
                                SizedBox(
                                  height: 5,
                                ),
                                Text('Price: Rs.${widget.productPrice}')
                              ],
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    'Rs.${widget.productCurrentBid} Current Bid'),
                                SizedBox(
                                  height: 5,
                                ),
                                // Text('4d 3h Time Left'),
                                countDownTimer(
                                    widget.bidEndTimeInSeconds!.toInt()),
                              ],
                            ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('PTA Aproved'),
                              widget.productPTAApproved == true
                                  ? Icon(
                                      Icons.done_rounded,
                                      color: Colors.green,
                                    )
                                  : Icon(
                                      Icons.cancel_rounded,
                                      color: Colors.red,
                                    )
                            ],
                          ),
                          Text('Shipping: Rs.${widget.productShipping}'),
                        ],
                      )
                    ],
                  ),
                ),
                widget.isStartingBid == false
                    ? SizedBox()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 35,
                            width: MediaQuery.of(context).size.width / 2.2,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  alignLabelWithHint: false,
                                  border: OutlineInputBorder(gapPadding: 113),
                                  contentPadding:
                                      EdgeInsets.only(top: 4, left: 6),
                                  // labelText: 'Label',
                                  hintText: 'Your Bid Amount'
                                  // height: 60, // Set the height of the text field
                                  ),
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          AppWidgets().myElevatedBTN(
                            btnWith: MediaQuery.of(context).size.width / 2.5,
                            btnHeight: 35.0,
                            onPressed: () async {
                              GuestDirectionToLogin()
                                  .guestDirectionToLogin(context);
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
                        btnWith: MediaQuery.of(context).size.width / 1,
                        btnHeight: 35.0,
                        onPressed: () {
                          GuestDirectionToLogin()
                              .guestDirectionToLogin(context);
                        },
                        btnText: 'Buy it now: Rs.${widget.productPrice}',
                        btnColor: AppColors.buttonColorBlue),
                    AppWidgets().myElevatedBTN(
                        btnWith: MediaQuery.of(context).size.width / 1,
                        btnHeight: 35.0,
                        onPressed: () {
                          GuestDirectionToLogin()
                              .guestDirectionToLogin(context);
                        },
                        btnText: '❤ Add to wish list',
                        btnColor: AppColors.buttonColorBlue),
                    AppWidgets().myHeading2Text('Discription: '),
                    AppWidgets()
                        .myNormalText('     ${widget.productDescription}'),
                    SizedBox(
                      height: 12,
                    ),
                    AppWidgets().myHeading2Text('Specification: '),
                    AppWidgets()
                        .myNormalText('     ${widget.productSpecification}'),
                    SizedBox(
                      height: 5,
                    )
                  ],
                ),
              ],
            ),
          ),
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
