import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/ui/appbar/My_Drawer.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';

import 'Seller_Profile.dart';

class ProductPageOfCart extends StatefulWidget {
  String? cartImage1;
  String? cartImage2;
  String? cartImage3;
  String? cartImage4;
  String? cartImage5;
  String? cartImage6;
  String? cartCollectionName;
  String? cartName;
  String? cartDescription;
  String? cartSpecification;
  String? cartUid;
  String? cartShopkeeperUid;
  int? cartCurrentBid;
  int? cartShipping;
  int? cartPrice;
  DateTime? cartDateTime;
  DateTime? bidDateTimeLeft;
  bool? cartPTAApproved;
  ProductPageOfCart(
      {this.cartImage1,
      this.cartImage2,
      this.cartImage3,
      this.cartImage4,
      this.cartImage5,
      this.cartImage6,
      this.cartCollectionName,
      this.cartName,
      this.cartDescription,
      this.cartSpecification,
      this.cartUid,
      this.cartShopkeeperUid,
      this.cartCurrentBid,
      this.cartShipping,
      this.cartPrice,
      this.cartDateTime,
      this.bidDateTimeLeft,
      this.cartPTAApproved,
      Key? key})
      : super(key: key);

  @override
  State<ProductPageOfCart> createState() => _ProductPageOfCartState();
}

class _ProductPageOfCartState extends State<ProductPageOfCart> {
  final _fireStoreSnapshot =
      FirebaseFirestore.instance.collection('SellerCenterUsers');
  TextEditingController bidAmount = TextEditingController();

  CartProvider cartProvider = CartProvider();

  var currentBid = 0;
  var myBid = 0;
  bool _validate = false;

  @override
  void dispose() {
    bidAmount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // cartProvider = Provider.of(context);
    // currentBid = widget.cartCurrentBid!.toInt();
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 22,
            ),
            FutureBuilder<DocumentSnapshot>(
                future: _fireStoreSnapshot.doc(widget.cartShopkeeperUid).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
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
                                        name: snapshot.data!['Name'],
                                        profileImage:
                                            snapshot.data!['Profile_Image'],
                                        email: snapshot.data!['Email'],
                                        contactNo:
                                            snapshot.data!['Phone_Number'],
                                        reviews: double.parse(snapshot
                                            .data!['Total_Review_Rating']
                                            .toString()),
                                        totalNoOfReviews: snapshot
                                            .data!['Total_Number_of_Reviews'],
                                        uId: snapshot.data!['Uid'])));
                          },
                          child:
                              snapshot.data!['Profile_Image'].toString() == ''
                                  ? CircleAvatar(
                                      radius: 33,
                                      backgroundImage:
                                          AssetImage('assets/images/img.png'),
                                    )
                                  : CircleAvatar(
                                      radius: 33,
                                      backgroundImage: NetworkImage(snapshot
                                          .data!['Profile_Image']
                                          .toString()),
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
                                                        name: snapshot
                                                            .data!['Name'],
                                                        profileImage: snapshot
                                                                .data![
                                                            'Profile_Image'],
                                                        email: snapshot
                                                            .data!['Email'],
                                                        contactNo:
                                                            snapshot.data![
                                                                'Phone_Number'],
                                                        reviews: snapshot.data![
                                                            'Total_Review_Rating'],
                                                        totalNoOfReviews: snapshot
                                                                .data![
                                                            'Total_Number_of_Reviews'],
                                                        uId: snapshot
                                                            .data!['Uid'],
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
                      widget.cartImage1!,
                      height: 255,
                    ),
                  ),
                  Text(
                    widget.cartName!,
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Rs.${currentBid!.toInt()} Current Bid'),
                            myBid == 0
                                ? SizedBox()
                                : Text('Rs.${myBid.toInt()} your Bid'),
                            SizedBox(
                              height: 5,
                            ),
                            Text('4d 3h Time Left'),
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
                                widget.cartPTAApproved == true
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
                            Text('Shipping: Rs.${widget.cartShipping}'),
                          ],
                        )
                      ],
                    ),
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     SizedBox(
                  //       height: _validate ? 49 : 35,
                  //       width: MediaQuery.of(context).size.width / 2.2,
                  //       child: TextField(
                  //         controller: bidAmount,
                  //         keyboardType: TextInputType.number,
                  //         decoration: InputDecoration(
                  //             errorText:
                  //                 _validate ? 'Your bid amount is low' : null,
                  //             alignLabelWithHint: false,
                  //             border: OutlineInputBorder(gapPadding: 113),
                  //             contentPadding: EdgeInsets.only(top: 4, left: 6),
                  //             // labelText: 'Label',
                  //             hintText: 'Your Bid Amount'
                  //             // height: 60, // Set the height of the text field
                  //             ),
                  //         style: TextStyle(fontSize: 12),
                  //       ),
                  //     ),
                  //     AppWidgets().myElevatedBTN(
                  //       btnWith: MediaQuery.of(context).size.width / 2.5,
                  //       btnHeight: 35.0,
                  //       onPressed: () {
                  //         int bid = int.parse(bidAmount.text.toString());
                  //         print(bid);
                  //         if (bid > 9999999) {
                  //           Utils.flutterToast('Your Bid Amount is too high');
                  //           return;
                  //         }
                  //         if (bid > currentBid!) {
                  //           // bidAmount.text.isEmpty || bid < currentBid ? _validate = true : _validate = false;
                  //           _validate = false;
                  //           myBid = bid;
                  //           currentBid = bid;
                  //           bidAmount.clear();
                  //
                  //           ProgressDialog progressDialog2 = ProgressDialog(
                  //             context,
                  //             title: const Text('Creating Your Bid !!!'),
                  //             message: const Text('Please wait'),
                  //           );
                  //           setState(() {});
                  //           progressDialog2.show();
                  //           try {
                  //             cartProvider.addCartData(
                  //               cartImage1: widget.cartImage1,
                  //               cartDescription: widget.cartDescription,
                  //               cartPTAApproved: widget.cartPTAApproved,
                  //               cartName: widget.cartName,
                  //               cartCurrentBid: currentBid,
                  //               cartUid: widget.cartUid,
                  //             );
                  //             FirebaseFirestore.instance
                  //                 .collection(
                  //                     widget.cartCollectionName.toString())
                  //                 .doc(widget.cartUid)
                  //                 .update({
                  //               "productCurrentBid": currentBid,
                  //               "higherBidder": FirebaseAuth
                  //                   .instance.currentUser!.uid
                  //                   .toString()
                  //             });
                  //             progressDialog2.dismiss();
                  //             Utils.flutterToast('Your Bid is Created!');
                  //           } catch (e) {
                  //             progressDialog2.dismiss();
                  //             Utils.flutterToast(e.toString());
                  //           }
                  //
                  //           setState(() {});
                  //         } else {
                  //           bidAmount.text.isEmpty || bid <= currentBid!
                  //               ? _validate = true
                  //               : _validate = false;
                  //           setState(() {});
                  //         }
                  //       },
                  //       btnText: 'Bid',
                  //       btnColor: AppColors.buttonColorBlue,
                  //     )
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppWidgets().myElevatedBTN(
                          btnWith: MediaQuery.of(context).size.width / 1,
                          btnHeight: 35.0,
                          onPressed: () {},
                          btnText: 'Buy it now: Rs.${widget.cartPrice}',
                          btnColor: AppColors.buttonColorBlue),
                      // AppWidgets().myElevatedBTN(
                      //     btnWith: MediaQuery.of(context).size.width / 1,
                      //     btnHeight: 35.0,
                      //     onPressed: () {},
                      //     btnText: '❤ Add to wish list',
                      //     btnColor: AppColors.buttonColorBlue),
                      AppWidgets().myHeading2Text('Discription: '),
                      AppWidgets()
                          .myNormalText('     ${widget.cartDescription}'),
                      SizedBox(
                        height: 12,
                      ),
                      AppWidgets().myHeading2Text('Specification: '),
                      AppWidgets()
                          .myNormalText('     ${widget.cartSpecification}'),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
