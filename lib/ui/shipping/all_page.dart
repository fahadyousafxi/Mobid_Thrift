import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:mobidthrift/ui/shipping/payment_to_seller.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import 'my_reviews_tab_bar.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key}) : super(key: key);

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  final _firebaseFireStore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;

  bool loading1 = false;

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
              child: cartProvider.getCartDataList.isEmpty
                  ? Center(
                      child: Text('There is no products'),
                    )
                  : ListView.builder(
                      itemCount: cartProvider.getCartDataList.length,
                      itemBuilder: (context, index) {
                        var data = cartProvider.getCartDataList[index];
                        // for (var i = 0; i <= cartProvider.getCartDataList.length;) {
                        //   price = price + data.cartCurrentBid!.toInt();
                        // }
                        return data.pleaseWait! == 'Finished'
                            ? SizedBox()
                            : Card(
                                clipBehavior: Clip.antiAlias,
                                elevation: 4,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(11.0),
                                ),
                                child: GestureDetector(
                                  onDoubleTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ProductPageOfCart(
                                    //               cartName:
                                    //                   data.cartName.toString(),
                                    //               cartCurrentBid:
                                    //                   data.cartCurrentBid,
                                    //               cartDescription: data
                                    //                   .cartDescription
                                    //                   .toString(),
                                    //               cartUid:
                                    //                   data.cartUid.toString(),
                                    //               cartImage1:
                                    //                   data.cartImage1.toString(),
                                    //               cartShipping: data.cartShipping,
                                    //               cartPrice: data.cartPrice,
                                    //               cartPTAApproved:
                                    //                   data.cartPTAApproved,
                                    //               cartShopkeeperUid:
                                    //                   data.cartShopkeeperUid,
                                    //               cartSpecification:
                                    //                   data.cartSpecification,
                                    //             )));
                                  },
                                  onTap: () {},
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
                                                          BorderRadius.circular(
                                                              11),
                                                      child: Image(
                                                        // The Data will be loaded from firebse
                                                        image: NetworkImage(data
                                                            .cartImage1
                                                            .toString()),
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
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                                  SizedBox(
                                                    height: 2,
                                                  ),
                                                  Text(
                                                    data.cartDescription
                                                        .toString(),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        'Price: Rs.${data.cartPrice.toString()} ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      // Text('is current bid '),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 11,
                                                  ),
                                                  data.pleaseWait == 'To Ship'
                                                      ? toShip()
                                                      : data.pleaseWait ==
                                                              'Rejected'
                                                          ? rejected()
                                                          : data.pleaseWait ==
                                                                  'To Pay'
                                                              ? Container(
                                                                  height: 25,
                                                                  width: 70,
                                                                  child: AppWidgets()
                                                                      .myElevatedBTN(
                                                                          onPressed:
                                                                              () {
                                                                            showDialog(
                                                                                context: context,
                                                                                builder: (context) {
                                                                                  return Center(
                                                                                    child: AlertDialog(
                                                                                      title: const Text('Congratulations!!'),
                                                                                      content: const Text('Please confirm yor payment'),
                                                                                      actions: [
                                                                                        TextButton(
                                                                                          onPressed: () {
                                                                                            Navigator.pop(context);
                                                                                            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentToSeller(productCollectionName: data.cartCollectionName.toString(), productPrice: data.cartPrice, productUid: data.cartUid.toString(), productShippingPrice: data.cartShipping)));
                                                                                          },
                                                                                          child: Text('ok'),
                                                                                        )
                                                                                      ],
                                                                                    ),
                                                                                  );
                                                                                });
                                                                            // _firebaseFireStore
                                                                            //     .collection(
                                                                            //         "Cart")
                                                                            //     .doc(_currentUser
                                                                            //         .toString())
                                                                            //     .collection(
                                                                            //         "YourCart")
                                                                            //     .doc(data
                                                                            //         .cartUid)
                                                                            //     .update({
                                                                            //   'pleaseWait':
                                                                            //       'To Ship',
                                                                            //   // 'SellerStatus': 'false',
                                                                            // }).then((value) {

                                                                            // });
                                                                          },
                                                                          btnText:
                                                                              'Pay',
                                                                          btnColor:
                                                                              Colors.blue),
                                                                )
                                                              : data.pleaseWait ==
                                                                      'To Review'
                                                                  ? toReview()
                                                                  : data.pleaseWait ==
                                                                          'To Report'
                                                                      ? toReport()
                                                                      : data.pleaseWait ==
                                                                              'To Report'
                                                                          ? Container(
                                                                              height: 25,
                                                                              width: 100,
                                                                              child: AppWidgets().myElevatedBTN(
                                                                                  loading: loading1,
                                                                                  onPressed: () {
                                                                                    if (loading1 == false) {
                                                                                      setState(() {
                                                                                        loading1 = true;
                                                                                      });
                                                                                      _firebaseFireStore.collection("Cart").doc(_currentUser.toString()).collection("YourCart").doc(data.cartUid).update({
                                                                                        'pleaseWait': 'To Review',
                                                                                        // 'SellerStatus': 'false',
                                                                                      }).then((value) {
                                                                                        setState(() {
                                                                                          loading1 = false;
                                                                                        });
                                                                                        showDialog(
                                                                                            context: context,
                                                                                            builder: (context) {
                                                                                              return Center(
                                                                                                child: AlertDialog(
                                                                                                  title: const Text('Congratulations!!'),
                                                                                                  content: const Text('Do you want to give review'),
                                                                                                  actions: [
                                                                                                    TextButton(
                                                                                                      onPressed: () {
                                                                                                        Navigator.pop(context);
                                                                                                      },
                                                                                                      child: Text('Not Now'),
                                                                                                    ),
                                                                                                    TextButton(
                                                                                                      onPressed: () {
                                                                                                        Navigator.pop(context);
                                                                                                      },
                                                                                                      child: const Text('Review'),
                                                                                                    ),
                                                                                                  ],
                                                                                                ),
                                                                                              );
                                                                                            });
                                                                                      }).onError((error, stackTrace) {
                                                                                        Utils.flutterToast(error.toString());
                                                                                        setState(() {
                                                                                          loading1 = false;
                                                                                        });
                                                                                      });
                                                                                    } else {
                                                                                      Utils.flutterToast('please wait');
                                                                                    }
                                                                                  },
                                                                                  btnText: 'Received',
                                                                                  btnColor: Colors.blue),
                                                                            )
                                                                          : SizedBox(),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      data.pleaseWait == 'To Pay' ||
                                              data.pleaseWait == 'Rejected'
                                          ? Positioned(
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
                                                                  onPressed:
                                                                      () {
                                                                    Navigator.pop(
                                                                        context);
                                                                  },
                                                                  child: Text(
                                                                      'No')),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  _firebaseFireStore
                                                                      .collection(
                                                                          "Cart")
                                                                      .doc(_auth
                                                                          .toString())
                                                                      .collection(
                                                                          "YourCart")
                                                                      .doc(data
                                                                          .cartUid)
                                                                      .delete()
                                                                      .then(
                                                                          (value) {
                                                                    Utils.flutterToast(
                                                                        'Deleted');
                                                                  }).onError((error,
                                                                          stackTrace) {
                                                                    Utils.flutterToast(
                                                                        error
                                                                            .toString());
                                                                  });
                                                                },
                                                                child: Text(
                                                                    'Delete'),
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
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ),
                              );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget toShip() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          'Processing...  ',
          style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget toReview() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MyReviewsTabBar(iniIndex: 0)));
          },
          child: Text(
            'waiting for review',
            style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }

  Widget toReport() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          'Ready to report',
          style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget rejected() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: const [
        Text(
          'Rejected  ',
          style: TextStyle(color: Colors.red, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }
}
