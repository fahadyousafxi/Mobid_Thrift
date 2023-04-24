import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobidthrift/constants/App_widgets.dart';
import 'package:mobidthrift/providers/Cart_Provider.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';

class ToPay extends StatefulWidget {
  const ToPay({Key? key}) : super(key: key);

  @override
  State<ToPay> createState() => _ToPayState();
}

class _ToPayState extends State<ToPay> {
  final _firebaseFireStore = FirebaseFirestore.instance;
  final _currentUser = FirebaseAuth.instance.currentUser!.uid;

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
                    return data.pleaseWait! != 'To Ship'
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
                                                              FontWeight.bold),
                                                    ),
                                                    // Text('is current bid '),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 11,
                                                ),
                                                Container(
                                                  height: 25,
                                                  width: 70,
                                                  child:
                                                      AppWidgets()
                                                          .myElevatedBTN(
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) {
                                                                      return Center(
                                                                        child:
                                                                            AlertDialog(
                                                                          title:
                                                                              const Text('Congratulations!!'),
                                                                          content:
                                                                              const Text('The seller will contact you very soon!'),
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
                                                                    .collection(
                                                                        "Cart")
                                                                    .doc(_currentUser
                                                                        .toString())
                                                                    .collection(
                                                                        "YourCart")
                                                                    .doc(data
                                                                        .cartUid)
                                                                    .update({
                                                                  'pleaseWait':
                                                                      'To Ship',
                                                                  // 'SellerStatus': 'false',
                                                                });
                                                              },
                                                              btnText: 'Pay',
                                                              btnColor:
                                                                  Colors.blue),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    data.pleaseWait == 'To Pay'
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
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child:
                                                                    Text('No')),
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
                                            ))
                                        : SizedBox()
                                  ],
                                )),
                          );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
