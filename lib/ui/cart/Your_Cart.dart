import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_colors.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/ui/Product_Page_of_Cart.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class YourCart extends StatefulWidget {
  const YourCart({Key? key}) : super(key: key);

  @override
  State<YourCart> createState() => _YourCartState();
}

class _YourCartState extends State<YourCart> {
  final _firebaseFireStore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;
  int totalPrice = 0;
  String productName = '____';
  String productImage = '';
  String productCollectionName = '';
  String productUid = '';
  String shopKeeperUid = '';
  String productDescription = '';
  String productSpecifications = '';
  int productShipping = 0;
  bool? productPTAApproved = false;

  final _auth = FirebaseAuth.instance.currentUser!.uid;
  CartProvider cartProvider = CartProvider();
  @override
  void initState() {
    CartProvider cartProvider = Provider.of(context, listen: false);

    cartProvider.getCartData();
    // TODO: implement initState
    super.initState();
  }

  @override
  void deactivate() {
    cartProvider.getCartDataList.clear();
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    cartProvider.getCartData();

    return Scaffold(
      // appBar: MyAppbar().mySimpleAppBar(context, title: 'Your Cart'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: cartProvider.getCartDataList.length,
                  itemBuilder: (context, index) {
                    var data = cartProvider.getCartDataList[index];
                    // for (var i = 0; i <= cartProvider.getCartDataList.length;) {
                    //   price = price + data.cartCurrentBid!.toInt();
                    // }
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11.0),
                      ),
                      child: GestureDetector(
                          onDoubleTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPageOfCart(
                                          cartName: data.cartName.toString(),
                                          cartCurrentBid: data.cartCurrentBid,
                                          cartDescription:
                                              data.cartDescription.toString(),
                                          cartUid: data.cartUid.toString(),
                                          cartImage1:
                                              data.cartImage1.toString(),
                                          cartShipping: data.cartShipping,
                                          cartPrice: data.cartPrice,
                                          cartPTAApproved: data.cartPTAApproved,
                                          cartShopkeeperUid:
                                              data.cartShopkeeperUid,
                                          cartSpecification:
                                              data.cartSpecification,
                                        )));
                          },
                          onTap: () {
                            totalPrice = data.cartPrice!;
                            productName = data.cartName!;
                            productUid = data.cartUid!;
                            productCollectionName =
                                data.cartCollectionName!.toString();
                            productImage = data.cartImage1.toString();
                            shopKeeperUid = data.cartShopkeeperUid!;
                            productDescription = data.cartDescription!;
                            productSpecifications = data.cartSpecification!;
                            productShipping = data.cartShipping!;
                            productPTAApproved = data.cartPTAApproved!;
                          },
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      // width: 162,
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 130,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(11),
                                              child: Image(
                                                // The Data will be loaded from firebse
                                                image: NetworkImage(
                                                    data.cartImage1.toString()),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                              child: Text(
                                            data.cartName.toString(),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          )),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Text(
                                            data.cartDescription.toString(),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Price: Rs.${data.cartPrice.toString()} ',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // Text('is current bid '),
                                            ],
                                          ),
                                          data.pleaseWait! == ''
                                              ? Text('Tap to checkout')
                                              : data.sellerStatus == ''
                                                  ? Text(
                                                      data.pleaseWait!,
                                                      style: TextStyle(
                                                          color: Colors.red),
                                                    )
                                                  : Text(data.sellerStatus
                                                      .toString()),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Positioned(
                                  right: 0,
                                  top: 0,
                                  child: IconButton(
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return Center(
                                              child: AlertDialog(
                                                title: const Text(
                                                    'Confirmation!!'),
                                                content: const Text(
                                                    'Are You Sure to Delete?'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text('No')),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      _firebaseFireStore
                                                          .collection("Cart")
                                                          .doc(_auth.toString())
                                                          .collection(
                                                              "YourCart")
                                                          .doc(data.cartUid)
                                                          .delete()
                                                          .then((value) {
                                                        Utils.flutterToast(
                                                            'Deleted');
                                                      }).onError((error,
                                                              stackTrace) {
                                                        Utils.flutterToast(
                                                            error.toString());
                                                      });
                                                    },
                                                    child: Text('Delete'),
                                                  )
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    icon: Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ),
                                  ))
                            ],
                          )),
                    );
                  }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        width: double.infinity,
        decoration: BoxDecoration(color: AppColors.myBlackColor),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 1,
            ),
            AppWidgets().myHeading2Text('Product Name: ${productName}',
                color: AppColors.myWhiteColor),
            AppWidgets().myHeading2Text('Total: Rs.${totalPrice}',
                color: AppColors.myWhiteColor),
            AppWidgets().myElevatedBTN(
                onPressed: () {
                  if (productUid != '') {
                    _firebaseFireStore
                        .collection('SoldProducts')
                        .doc(productUid)
                        .set({
                      'ProductPrice': totalPrice,
                      'ProductName': productName,
                      'ProductImage': productImage,
                      'ProductUid': productUid,
                      'ShopKeeperUid': shopKeeperUid,
                      'ProductDescription': productDescription,
                      'ProductSpecifications': productSpecifications,
                      'ProductShipping': productShipping,
                      'BuyerUid': _currentUser.toString(),
                      'ProductPTAApproved': productPTAApproved,
                      'SellerStatus': 'Seller did not respond till now',
                    }).then((value) {
                      _firebaseFireStore
                          .collection(productCollectionName)
                          .doc(productUid)
                          .delete()
                          .then((value) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: AlertDialog(
                                  title: const Text('Congratulations!!'),
                                  content: const Text(
                                      'The seller will contact you very soon!'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('ok'),
                                    )
                                  ],
                                ),
                              );
                            });
                        _firebaseFireStore
                          ..collection("Cart")
                              .doc(_currentUser.toString())
                              .collection("YourCart")
                              .doc(productUid)
                              .update({
                            'pleaseWait': 'Please wait OR Contact to seller',
                            // 'SellerStatus': 'false',
                          });
                      }).onError((error, stackTrace) {
                        Utils.flutterToast(error.toString());
                      });
                    }).onError((error, stackTrace) {
                      Utils.flutterToast(error.toString());
                    });
                  } else {
                    Utils.flutterToast('Please Select a Product');
                  }
                },
                btnText: 'Checkout',
                btnColor: AppColors.myRedColor)
          ],
        ),
      ),
    );
  }

  /// my Alert Dialog
  // Future myAlertDialog(context) {
  //   return showDialog(
  //       context: context,
  //       builder: (context) {
  //         return Center(
  //           child: AlertDialog(
  //             title: const Text('Confirmation!!'),
  //             content: const Text('Are You Sure to Delete?'),
  //             actions: [
  //               TextButton(
  //                   onPressed: () {
  //                     Navigator.pop(context);
  //                   },
  //                   child: Text('No')),
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //
  //                   final _auth = FirebaseAuth.instance;
  //                   FirebaseFirestore.instance
  //                       .collection("Cart")
  //                       .doc(_auth.toString())
  //                       .collection("YourCart")
  //                       .doc(data.cartUid)
  //                       .delete()
  //                       .then((value) {
  //                     Utils.flutterToast('Deleted');
  //                   }).onError((error, stackTrace) {
  //                     Utils.flutterToast(error.toString());
  //                   });
  //                 },
  //                 child: Text('Yes'),
  //               )
  //             ],
  //           ),
  //         );
  //       });
  // }
}
