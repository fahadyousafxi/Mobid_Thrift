import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/providers/Wish_List_Provider.dart';
import 'package:mobidthrift/providers/seller_provider.dart';
import 'package:mobidthrift/ui/Seller_Profile.dart';
import 'package:mobidthrift/ui/appbar/My_Drawer.dart';
import 'package:mobidthrift/ui/appbar/My_appbar.dart';
import 'package:mobidthrift/utils/utils.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {
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
  int? productPrice;
  DateTime? productDateTime;
  DateTime? bidDateTimeLeft;
  bool? productPTAApproved;
  ProductPage(
      {this.productImage1,
      this.productImage2,
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
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
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
    // _sellerProvider.getSellerData(widget.productShopkeeperUid.toString());
    if (auth != null) {
      cartProvider = Provider.of(context);
      wishListProvider = Provider.of(context);
      currentBid = widget.productCurrentBid!.toInt();
    }
    return Scaffold(
      appBar: MyAppbar().myAppBar(context),
      drawer: MyDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder<DocumentSnapshot>(
            future: _fireStoreSnapshot,
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.blue,
                ));

              if (snapshot.hasError) return Center(child: Text('Some Error'));

              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 22,
                  ),
                  Container(
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
                                        reviews: snapshot
                                            .data!['Total_Review_Rating'],
                                        totalNoOfReviews: snapshot
                                            .data!['Total_Number_of_Reviews'],
                                        uId: snapshot.data!['Uid'])));
                          },
                          child: CircleAvatar(
                            radius: 33,
                            backgroundImage: snapshot.data!['Profile_Image']
                                        .toString() ==
                                    ''
                                ? AssetImage('assets/images/img.png')
                                : AssetImage(
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
                                        Text('  (' +
                                                snapshot.data![
                                                        'Total_Review_Rating']
                                                    .toString()
                                                    .substring(0, 1) +
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
                  ),
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
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                  Text(
                                      'Shipping: Rs.${widget.productShipping}'),
                                ],
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: _validate ? 49 : 35,
                              width: MediaQuery.of(context).size.width / 2.2,
                              child: TextField(
                                controller: bidAmount,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    errorText: _validate
                                        ? 'Your bid amount is low'
                                        : null,
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
                              onPressed: () {
                                int bid = int.parse(bidAmount.text.toString());
                                print(bid);
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
                                    title: const Text('Creating Your Bid !!!'),
                                    message: const Text('Please wait'),
                                  );
                                  setState(() {});
                                  progressDialog2.show();
                                  try {
                                    cartProvider.addCartData(
                                      cartImage1: widget.productImage1,
                                      cartDescription:
                                          widget.productDescription,
                                      cartPTAApproved:
                                          widget.productPTAApproved,
                                      cartName: widget.productName,
                                      cartCurrentBid: currentBid,
                                      cartUid: widget.productUid,
                                    );
                                    FirebaseFirestore.instance
                                        .collection(widget.productCollectionName
                                            .toString())
                                        .doc(widget.productUid)
                                        .update(
                                            {"productCurrentBid": currentBid});
                                    progressDialog2.dismiss();
                                    Utils.flutterToast('Your Bid is Created!');
                                  } catch (e) {
                                    progressDialog2.dismiss();
                                    Utils.flutterToast(e.toString());
                                  }

                                  setState(() {});
                                } else {
                                  bidAmount.text.isEmpty || bid <= currentBid!
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
                                btnWith: MediaQuery.of(context).size.width / 1,
                                btnHeight: 35.0,
                                onPressed: () {},
                                btnText:
                                    'Buy it now: Rs.${widget.productPrice}',
                                btnColor: AppColors.buttonColorBlue),
                            AppWidgets().myElevatedBTN(
                                btnWith: MediaQuery.of(context).size.width / 1,
                                btnHeight: 35.0,
                                onPressed: () {
                                  Utils.flutterToast('Added to Your WishList');
                                  wishListProvider.addToWishList(
                                      collectionName: widget
                                          .productCollectionName
                                          .toString(),
                                      productUid: widget.productUid.toString(),
                                      wishlistUid: DateTime.now()
                                          .microsecondsSinceEpoch
                                          .toString());
                                },
                                btnText: '❤ Add to wish list',
                                btnColor: AppColors.buttonColorBlue),
                            AppWidgets().myHeading2Text('Discription: '),
                            AppWidgets().myNormalText(
                                '     ${widget.productDescription}'),
                            SizedBox(
                              height: 12,
                            ),
                            AppWidgets().myHeading2Text('Specification: '),
                            AppWidgets().myNormalText(
                                '     ${widget.productSpecification}'),
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
      ),
    );
  }
}
